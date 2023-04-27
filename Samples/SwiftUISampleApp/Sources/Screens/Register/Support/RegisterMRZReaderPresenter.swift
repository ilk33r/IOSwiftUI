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
import IOSwiftUISupportCamera
import IOSwiftUISupportNFC
import IOSwiftUISupportVisionDetectText
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

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
            
            Task { [weak self] in
                guard let self else { return }
                await self.parseNFCDG(dg: dg, data: data)
            }
        }
        
        self.tagReader.error { [weak self] error in
            self?.messageForNFCError(error: error) ?? .nfcError0
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
                return .nfcInfo1
                
            case .reading:
                return .nfcInfo2
                
            case .error:
                return .nfcError0
                
            case .finished:
                return .nfcInfo3
            }
        }
    }
    
    // MARK: - Presenter
    
    func parseMRZ(detectedTexts: [[String]]) async {
        if self.mrzParsed {
            return
        }
        
        do {
            let mrzModel = try await self.interactor.parseMRZ(detectedTexts: detectedTexts)
            self.mrzParsed = true
            
            Task { [weak self] in
                guard let self else { return }
                await self.startNFCScaning(mrzModel: mrzModel.modelData)
            }
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func update(cameraError: IOCameraError) async {
        switch cameraError {
        case .authorization(errorMessage: let errorMessage, settingsURL: let settingsURL):
            let index = await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: errorMessage,
                    buttons: [.commonCancel, .commonOk]
                )
            }
            
            if index == 1, let settingsURL {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
            
        case .deviceError(errorMessage: let errorMessage):
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: errorMessage,
                    buttons: [.commonOk]
                )
            }
            
        case .deviceNotFound:
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .cameraDeviceNotFound,
                    buttons: [.commonOk],
                    handler: nil
                )
            }
        }
    }
    
    @MainActor
    func rescanID() async {
        await self.readIdentity(readerData: self.readerData)
    }
    
    // MARK: - Helper Methods
    
    @MainActor
    private func startNFCScaning(mrzModel: IOVisionIdentityMRZModel.ModelData) async {
        self.isCameraRunning = false
        
        let readerData = IOISO7816ReaderData(
            documentNumber: mrzModel.documentNumber ?? "",
            birthdate: mrzModel.birthDate ?? "",
            validUntilDate: mrzModel.expireDate ?? ""
        )
        
        self.readerData = readerData
        await self.readIdentity(readerData: readerData)
    }
    
    @MainActor
    private func readIdentity(readerData: IOISO7816ReaderData) async {
        do {
            try self.tagReader.startScanning(data: readerData)
        } catch let err as IONFCError {
            let message = self.messageForNFCError(error: err)
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: message,
                    buttons: [.commonOk]
                )
            }
            
            self.thread.runOnMainThread(afterMilliSecond: 150) { [weak self] in
                self?.showNFCErrorBottomSheet = true
            }
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    private func messageForNFCError(error: IONFCError) -> IOLocalizationType {
        switch error {
        case .readingNotAvailable:
            return .nfcError1
            
        case .authenticationDataIsEmpty:
            return .nfcError0
            
        case .userCancelled:
            return .nfcError0
            
        case .tagValidation:
            return .nfcError2
            
        case .tagConnection(message: let message):
            return IOLocalizationType(rawValue: message)
            
        case .keyDerivation:
            return .nfcError2
            
        case .connectionLost:
            return .nfcError3
            
        case .tagRead:
            return .nfcError4
            
        case .authentication:
            return .nfcError2
            
        case .tagResponse:
            return .nfcError4
        }
    }
    
    private func parseNFCDG(dg: IONFCISO7816DataGroup, data: Data) async {
        do {
            try await self.interactor.parseNFCDG(dg: dg, data: data)
        } catch let err {
            IOLogger.error(err.localizedDescription)
            self.updateError()
        }
    }
    
    private func updateError() {
        self.thread.runOnMainThread(afterMilliSecond: 2500) { [weak self] in
            self?.showNFCErrorBottomSheet = true
        }
    }
}
