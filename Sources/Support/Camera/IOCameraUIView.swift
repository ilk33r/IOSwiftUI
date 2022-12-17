//
//  IOCameraUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import AVFoundation
import Foundation
import UIKit
import IOSwiftUIInfrastructure

final public class IOCameraUIView: UIView {
    
    // MARK: - Defs
    
    public typealias InitializationHandler = (_ isReady: Bool, _ error: IOCameraError?) -> Void
    public typealias QROutputHandler = (_ data: String) -> Void
    public typealias StreamOutputHandler = (_ data: CMSampleBuffer) -> Void
    
    // MARK: - Constants
    
    private let cameraAppPrefPrivacy = "Privacy&path=CAMERA"
    private let cameraOutputQueueName = "com.ioswiftui.support.camera"
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private var cameraOutputQueue: DispatchQueue?
    private var captureSession: AVCaptureSession?
    private var initializationHandler: InitializationHandler!
    private var orientation: IOCameraOrientation!
    private var qrOutputHandler: QROutputHandler?
    private var streamOutputHandler: StreamOutputHandler?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer! { (self.layer as! AVCaptureVideoPreviewLayer) }
    
    // MARK: - Overrides
    
    public override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
    
    // MARK: - Initialization Methods
    
    public func setupCamera(
        _ outputType: IOCameraOutputType,
        position: IOCameraPosition = .back,
        orientation: IOCameraOrientation = .portrait,
        handler: InitializationHandler!
    ) {
        self.orientation = orientation
        self.initializationHandler = handler
        
        // Request camera access
        self.requestAuthorization { [weak self] error in
            if let error {
                self?.thread.runOnMainThread {
                    self?.initializationHandler(false, error)
                }
                
                return
            }
            
            // Configure capture session
            self?.configureCaptureSession(outputType: outputType, position: position)
            
            // Start camera
            self?.startCamera()
            
            // Post configure output
            self?.postConfigure(forType: outputType)
        }
    }
    
    // MARK: - Camera Methods
    
    public func startCamera() {
        self.thread.runOnMainThread { [weak self] in
            // Check camera is not running
            if self?.captureSession?.isRunning ?? false {
                return
            }
            
            // Check orientation is supported
            if self?.videoPreviewLayer.connection?.isVideoOrientationSupported ?? false {
                // Then set orientation
                if self?.orientation == .portrait {
                    self?.videoPreviewLayer.connection?.videoOrientation = .portrait
                } else {
                    self?.videoPreviewLayer.connection?.videoOrientation = .landscapeRight
                }
            }
            
            // Then start camera
            self?.thread.runOnBackgroundThread {
                self?.captureSession?.startRunning()
            }
        }
    }

    public func stopCamera() {
        self.thread.runOnMainThread { [weak self] in
            // Check camera is running
            if self?.captureSession?.isRunning ?? false {
                // Then stop camera
                self?.captureSession?.stopRunning()
            }
        }
    }

    public func toggleTorch() {
        let captureDevice = self.captureDevice(for: .back)
        if captureDevice?.hasTorch ?? false {
            try? captureDevice?.lockForConfiguration()
            
            if captureDevice?.torchMode == .off {
                captureDevice?.torchMode = .on
            } else {
                captureDevice?.torchMode = .off
            }
            
            captureDevice?.unlockForConfiguration()
        }
    }
    
    // MARK: - Listeners
    
    public func setQROutput(handler: QROutputHandler?) {
        self.qrOutputHandler = handler
    }
    
    public func setStreamOutput(handler: StreamOutputHandler?) {
        self.streamOutputHandler = handler
    }
}

// MARK: - Capture Outputs

extension IOCameraUIView {
    
    private func output(forType outputType: IOCameraOutputType) -> AVCaptureOutput? {
        // Check output type
        if outputType == .qr {
            // Then return qr code output
            return self.qrCodeOutput()
        } else if outputType == .stream {
            return self.streamOutput()
        }
        
        return nil
    }
    
    private func postConfigure(forType outputType: IOCameraOutputType) {
        // Check output type
        if outputType == .qr {
            // Then configure qr code output
            self.postConfigureQROutput()
        }
    }
    
    private func qrCodeOutput() -> AVCaptureMetadataOutput {
        // Create queue
        if self.cameraOutputQueue == nil {
            self.cameraOutputQueue = DispatchQueue(label: self.cameraOutputQueueName)
        }
        
        // Create metadata output
        let metadataOutput = AVCaptureMetadataOutput()
        
        // Setup delegate
        metadataOutput.setMetadataObjectsDelegate(self, queue: self.cameraOutputQueue!)
        
        return metadataOutput
    }
    
    private func postConfigureQROutput() {
        // Obtain output
        let metadataOutput = self.captureSession?.outputs.first as? AVCaptureMetadataOutput
        
        // Obtain available metadata objects
        guard let availableMetadataObjects = metadataOutput?.availableMetadataObjectTypes else { return }
        
        // QR output
        let qrOutput = availableMetadataObjects.filter { $0 == AVMetadataObject.ObjectType.qr }
        
        // Set objetc type
        metadataOutput?.metadataObjectTypes = qrOutput
    }
    
    private func streamOutput() -> AVCaptureVideoDataOutput {
        // Create queue
        if self.cameraOutputQueue == nil {
            self.cameraOutputQueue = DispatchQueue(label: self.cameraOutputQueueName)
        }
        
        // Create metadata output
        let videoDataOutput = AVCaptureVideoDataOutput()
        
        // Setup delegate
        videoDataOutput.setSampleBufferDelegate(self, queue: self.cameraOutputQueue!)
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        
        return videoDataOutput
    }
}

// MARK: - Capture Session

extension IOCameraUIView {
    
    private func captureDevice(for position: IOCameraPosition) -> AVCaptureDevice? {
        // Create device position
        let devicePosition: AVCaptureDevice.Position
        
        // Check position
        if position == .back {
            // Set device position
            devicePosition = .back
        } else if position == .front {
            // Set device position
            devicePosition = .front
        } else {
            devicePosition = .back
        }
        
        // Create discovery session
        let deviceTypes = [
            AVCaptureDevice.DeviceType.builtInTrueDepthCamera,
            AVCaptureDevice.DeviceType.builtInDualCamera,
            AVCaptureDevice.DeviceType.builtInWideAngleCamera,
            AVCaptureDevice.DeviceType.builtInDualWideCamera,
            AVCaptureDevice.DeviceType.builtInTelephotoCamera
        ]
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: devicePosition)
        return discoverySession.devices.first
    }
    
    private func configureCaptureSession(outputType: IOCameraOutputType, position: IOCameraPosition) {
        // Create capture session
        self.captureSession = AVCaptureSession()
        
        // Obtain capture device
        let captureDevice = self.captureDevice(for: position)
        
        // Check capture device is not found
        guard let captureDevice else {
            // Call handler
            self.thread.runOnMainThread { [weak self] in
                self?.initializationHandler(false, .deviceNotFound)
            }
            
            // Do nothing
            return
        }
        
        do {
            // Create input
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            // Begin session configuration
            self.captureSession?.beginConfiguration()
            
            // Check input can add
            if self.captureSession?.canAddInput(deviceInput) ?? false {
                // Then add input
                self.captureSession?.addInput(deviceInput)
            }
            
            // Obtain output
            let output = self.output(forType: outputType)
            if
                let output = output,
                self.captureSession?.canAddOutput(output) ?? false {
                // Then add output
                self.captureSession?.addOutput(output)
            }
            
            // Check orientation
            let conn = output?.connection(with: .video)
            if self.orientation == .portrait {
                conn?.videoOrientation = .portrait
            } else {
                conn?.videoOrientation = .landscapeRight
            }
            
            // Commit configuration
            self.captureSession?.commitConfiguration()
            
            // Update preview layer
            self.thread.runOnMainThread { [weak self] in
                self?.videoPreviewLayer.session = self?.captureSession
                self?.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            }
            
            // Call handler
            self.thread.runOnMainThread { [weak self] in
                self?.initializationHandler(true, nil)
            }
        } catch let error {
            // Call handler
            self.thread.runOnMainThread { [weak self] in
                self?.initializationHandler(false, .deviceError(errorMessage: error.localizedDescription))
            }
        }
    }
}

// MARK: - Permission

extension IOCameraUIView {
    
    private func generateSettingsURL() -> URL? {
        // Redirect to location services
        let preferenceUrlString = String(format: "%@:root=%@", UIApplication.openSettingsURLString, self.cameraAppPrefPrivacy)
        return URL(string: preferenceUrlString)
    }
    
    private func requestAuthorization(handler: @escaping (_ error: IOCameraError?) -> Void) {
        // Obtain authorization status
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        // Check authorization status
        if authorizationStatus == .authorized {
            // Then call handler
            handler(nil)
        } else if authorizationStatus == .notDetermined {
            // Request authorization
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                // Check access granted
                if granted {
                    // Then call handler
                    handler(nil)
                    
                    // Do nothing
                    return
                }
                
                handler(
                    .authorization(
                        errorMessage: .cameraAccessDeniedMessage,
                        settingsURL: self?.generateSettingsURL()
                    )
                )
            }
        } else if authorizationStatus == .denied {
            // Show alert
            handler(
                .authorization(
                    errorMessage: .cameraAccessDeniedMessage,
                    settingsURL: self.generateSettingsURL()
                )
            )
        } else if authorizationStatus == .restricted {
            // Show alert
            handler(
                .authorization(
                    errorMessage: .cameraAccessRestrictedMessage,
                    settingsURL: self.generateSettingsURL()
                )
            )
        }
    }
}

// MARK: - Output Delegate

extension IOCameraUIView: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        // Obtain object
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }

        // Call handler
        if self.captureSession?.isRunning ?? false {
            self.qrOutputHandler?(metadataObject.stringValue ?? "")
        }
    }
}

extension IOCameraUIView: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    public func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        // Call handler
        if self.captureSession?.isRunning ?? false {
            self.streamOutputHandler?(sampleBuffer)
        }
    }
}
