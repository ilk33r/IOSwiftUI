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
    
    // MARK: - Initialization Methods
    
    public init() {
        self.uiModel = nil
    }
    
    // MARK: - Presenter
    
    func update(otpTimeout: Int) {
        self.uiModel = SendOTPUIModel(
            phoneNumber: self.interactor.entity.phoneNumber ?? "",
            otpTimeout: otpTimeout
        )
    }
    
    func updateOTPTimeout() {
        self.showAlert { [weak self] in
            IOAlertData(
                title: nil,
                message: .sendOTPErrorTimeoutMessage,
                buttons: [.commonOk]
            ) { [weak self] _ in
                self?.interactor.entity.isPresented.wrappedValue = false
            }
        }
    }
}
