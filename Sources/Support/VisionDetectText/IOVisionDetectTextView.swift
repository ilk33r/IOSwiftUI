//
//  IOVisionDetectTextView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUISupportCamera
import SwiftUI

public struct IOVisionDetectTextView: View {
    
    // MARK: - Defs
    
    public typealias DetectionHandler = (_ texts: [[String]]) -> Void
    public typealias ErrorHandler = (_ error: IOCameraError) -> Void
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private let detectionHandler: DetectionHandler?
    private let errorHandler: ErrorHandler?
    private let visionText: IOVisionDetectText
    
    @Binding private var isFlashEnabled: Bool
    @Binding private var isRunning: Bool
    
    @State private var cameraView: IOCameraUIView?
    
    // MARK: - Body
    
    public var body: some View {
        IOCameraView { view in
            setupCamera(cameraView: view)
        }
        .onChange(of: isRunning) { newValue in
            if newValue {
                cameraView?.startCamera()
            } else {
                cameraView?.stopCamera()
            }
        }
        .onChange(of: isFlashEnabled) { newValue in
            cameraView?.toggleTorch(isOn: newValue)
        }
        .onDisappear {
            cameraView?.stopCamera()
            cameraView = nil
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        isRunning: Binding<Bool>,
        isFlashEnabled: Binding<Bool>,
        detectionHandler: DetectionHandler?,
        errorHandler: ErrorHandler?
    ) {
        self._isRunning = isRunning
        self._isFlashEnabled = isFlashEnabled
        self.visionText = IOVisionDetectText { results in
            detectionHandler?(results)
        }
        self.detectionHandler = detectionHandler
        self.errorHandler = errorHandler
    }
    
    // MARK: - Helper Methods
    
    private func setupCamera(cameraView: IOCameraUIView?) {
        if self.cameraView != nil {
            return
        }
        
        if ProcessInfo.isPreviewMode {
            return
        }
        
        cameraView?.setupCamera(.stream) { isReady, error in
            if let error {
                errorHandler?(error)
                return
            }
            
            if isReady {
                cameraView?.setStreamOutput { data in
                    visionText.detectText(buffer: data)
                }
                
                thread.runOnMainThread {
                    self.cameraView = cameraView
                }
            }
        }
    }
}
