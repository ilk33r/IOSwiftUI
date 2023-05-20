// 
//  SendOTPPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class SendOTPPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SendOTPInteractor!
    public var navigationState: StateObject<SendOTPNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var uiModel: SendOTPUIModel?
    
    // MARK: - Privates
    
    private var otpSended: Bool
    
    // MARK: - Initialization Methods
    
    public init() {
        self.uiModel = nil
        self.otpSended = false
    }
    
    // MARK: - Presenter
    
    @MainActor
    func otpSend() async {
        if self.otpSended {
            return
        }
        
        self.otpSended = true
        do {
            let otpTimeout = try await self.interactor.otpSend()
            self.uiModel = SendOTPUIModel(
                phoneNumber: self.interactor.entity.phoneNumber ?? "",
                otpTimeout: otpTimeout
            )
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func updateOTPTimeout() async {
        await self.showAlertAsync {
            IOAlertData(
                title: nil,
                message: .errorTimeoutMessage,
                buttons: [.commonOk]
            )
        }
        
        self.interactor.entity.isPresented.wrappedValue = false
    }
    
    @MainActor
    func otpVerify(otp: String) async {
        do {
            try await self.interactor.otpVerify(otp: otp)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
