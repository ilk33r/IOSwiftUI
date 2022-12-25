// 
//  RegisterMRZReaderPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import IOSwiftUISupportCamera
import IOSwiftUISupportVisionDetectText
import SwiftUISampleAppScreensShared
import IOSwiftUISupportNFC

final public class RegisterMRZReaderPresenter: IOPresenterable {
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: RegisterMRZReaderInteractor!
    public var navigationState: StateObject<RegisterMRZReaderNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var isCameraRunning: Bool
    @Published var navigateToBack: Bool
    @Published var showNFCErrorBottomSheet: Bool
    
    // MARK: - Privates
    
    private var mrzParsed: Bool
    private var tagReader: IOISO7816TagReader
    private var readerData: IOISO7816ReaderData!
    
    // MARK: - Initialization Methods
    
    public init() {
        self.isCameraRunning = true
        self.navigateToBack = false
        self.showNFCErrorBottomSheet = false
        self.mrzParsed = false
        let dataGroups: [IONFCISO7816DataGroup] = [.dg1, .dg2, .dg11]
        self.tagReader = IOISO7816TagReader(dataGroups: dataGroups)
        
        self.tagReader.dataGroup { [weak self] dg, data in
            guard let dg = dg as? IONFCISO7816DataGroup else { return }
            guard let data else { return }
            self?.thread.runOnBackgroundThread { [weak self] in
                self?.interactor.parseNFCDG(dg: dg, data: data)
            }
        }
        
        self.tagReader.error { [weak self] error in
            return self?.messageForNFCError(error: error) ?? .registerNFCError0
        }
        
        self.tagReader.finish { [weak self] isSuccess in
            if !isSuccess {
                self?.updateError()
                return
            }
            
            self?.navigateToBack = true
        }
        
        self.tagReader.status { status in
            switch status {
            case .started:
                return .registerNfcInfo1
                
            case .reading:
                return .registerNFCInfo2
                
            case .error:
                return .registerNFCError0
                
            case .finished:
                return .registerNFCInfo3
            }
        }
    }
    
    // MARK: - Presenter
    
    func parseMRZ(detectedTexts: [[String]]) {
        if self.mrzParsed {
            return
        }
        
        self.interactor.parseMRZ(detectedTexts: detectedTexts)
    }
    
    func update(cameraError: IOCameraError) {
        switch cameraError {
        case .authorization(errorMessage: let errorMessage, settingsURL: let settingsURL):
            self.showAlert {
                IOAlertData(
                    title: nil,
                    message: errorMessage,
                    buttons: [.commonCancel, .commonOk],
                    handler: { index in
                        if index == 1, let settingsURL {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        }
                    }
                )
            }
            
        case .deviceError(errorMessage: let errorMessage):
            self.showAlert {
                IOAlertData(title: nil, message: errorMessage, buttons: [.commonOk], handler: nil)
            }
            
        case .deviceNotFound:
            self.showAlert {
                IOAlertData(title: nil, message: .registerCameraDeviceNotFound, buttons: [.commonOk], handler: nil)
            }
        }
    }
    
    func update(mrz: IOVisionIdentityMRZModel.ModelData) {
        self.mrzParsed = true
        
        self.thread.runOnMainThread { [weak self] in
            self?.isCameraRunning = false
            
            let readerData = IOISO7816ReaderData(
                documentNumber: mrz.documentNumber ?? "",
                birthdate: mrz.birthDate ?? "",
                validUntilDate: mrz.expireDate ?? ""
            )
            
            self?.readerData = readerData
            self?.readIdentity(readerData: readerData)
        }
    }
    
    func updateError() {
        self.thread.runOnMainThread(afterMilliSecond: 3000) { [weak self] in
            self?.showNFCErrorBottomSheet = true
        }
    }
    
    func rescanID() {
        self.readIdentity(readerData: self.readerData)
    }
    
    // MARK: - Helper Methods
    
    private func readIdentity(readerData: IOISO7816ReaderData) {
        do {
            try self.tagReader.startScanning(data: readerData)
        } catch let error {
            if let error = error as? IONFCError {
                let message = self.messageForNFCError(error: error)
                self.showAlert {
                    IOAlertData(
                        title: nil,
                        message: message,
                        buttons: [.commonOk],
                        handler: { [weak self] _ in
                            self?.thread.runOnMainThread(afterMilliSecond: 150) { [weak self] in
                                self?.showNFCErrorBottomSheet = true
                            }
                        }
                    )
                }
            }
        }
    }
    
    private func messageForNFCError(error: IONFCError) -> IOLocalizationType {
        switch error {
        case .readingNotAvailable:
            return .registerNFCError1
            
        case .authenticationDataIsEmpty:
            return .registerNFCError0
            
        case .userCancelled:
            return .registerNFCError0
            
        case .tagValidation:
            return .registerNFCError2
            
        case .tagConnection(message: let message):
            return IOLocalizationType(rawValue: message)
            
        case .keyDerivation:
            return .registerNFCError2
            
        case .connectionLost:
            return .registerNFCError3
            
        case .tagRead:
            return .registerNFCError4
            
        case .authentication:
            return .registerNFCError2
            
        case .tagResponse:
            return .registerNFCError4
        }
    }
}
