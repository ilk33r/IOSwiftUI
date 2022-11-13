// 
//  SettingsPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class SettingsPresenter: IOPresenterable {
    
    // MARK: - Defs
    
    struct ActionSheetData: Identifiable {
        
        let id = UUID()
    }
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SettingsInteractor!
    public var navigationState: StateObject<SettingsNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var actionSheetData: ActionSheetData?
    @Published private(set) var menu: [SettingsMenuItemUIModel]
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.menu = []
    }
    
    // MARK: - Presenter
    
    func navigate(menu: SettingsMenuItemUIModel) {
        switch menu.type {
        case .updateProfile:
            self.navigationState.wrappedValue.updateProfileEntity = UpdateProfileEntity(
                member: self.interactor.entity.member
            )
            self.navigationState.wrappedValue.navigateToUpdateProfile = true
            
        case .updateProfilePicture:
            self.actionSheetData = ActionSheetData()
            
        case .removeProfilePicture:
            self.showAlert { [weak self] in
                IOAlertData(
                    title: nil,
                    message: .settingsPromptDeleteProfilePicture,
                    buttons: [.commonYes, .commonNo]
                ) { [weak self] index in
                    if index == 0 {
                        self?.interactor.deleteProfilePicture()
                    }
                }
            }
            
        case .changePassword:
            self.navigationState.wrappedValue.changePasswordEntity = ChangePasswordEntity(
                phoneNumber: self.interactor.entity.member.phoneNumber ?? ""
            )
            self.navigationState.wrappedValue.navigateToChangePassword = true
            
        case .privacyPolicy:
            self.navigationState.wrappedValue.webEntity = WebEntity(
                pageName: "PrivacyPolicy",
                pageTitle: menu.localizableKey,
                titleIcon: menu.iconName
            )
            self.navigationState.wrappedValue.navigateToWeb = true
            
        case .termsAndConditions:
            self.navigationState.wrappedValue.webEntity = WebEntity(
                pageName: "TermsAndConditions",
                pageTitle: menu.localizableKey,
                titleIcon: menu.iconName
            )
            self.navigationState.wrappedValue.navigateToWeb = true
            
        case .logout:
            self.showAlert { [weak self] in
                IOAlertData(
                    title: nil,
                    message: .settingsPromptLogout,
                    buttons: [
                        .commonYes,
                        .commonNo
                    ]
                ) { [weak self] index in
                    if index == 0 {
                        self?.interactor.logout()
                    }
                }
            }
        }
    }
    
    func navigateSplash() {
        self.environment.wrappedValue.isLoggedIn = false
    }
    
    func update(menu: [SettingsMenuItemUIModel]) {
        self.menu = menu
    }
}
