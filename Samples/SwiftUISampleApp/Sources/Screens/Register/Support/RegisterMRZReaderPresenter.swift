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

final public class RegisterMRZReaderPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: RegisterMRZReaderInteractor!
    public var navigationState: StateObject<RegisterMRZReaderNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func handleCameraError(error: IOCameraError) {
        switch error {
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
}
