// 
//  SettingsInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct SettingsInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: SettingsEntity!
    public weak var presenter: SettingsPresenter?
    
    // MARK: - Privates
    
    @IOInstance private var service: IOServiceProviderImpl<SettingsService>
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func loadMenu() {
        var settingMenu = [SettingsMenuItemUIModel]()
        
        settingMenu.append(SettingsMenuItemUIModel(iconName: "person.fill", localizableKey: .settingsMenuUpdateProfile))
        settingMenu.append(SettingsMenuItemUIModel(iconName: "person.crop.circle", localizableKey: .settingsMenuUpdateProfilePicture))
        settingMenu.append(SettingsMenuItemUIModel(iconName: "person.crop.circle.badge.minus", localizableKey: .settingsMenuRemoveProfilePicture))
        settingMenu.append(SettingsMenuItemUIModel(iconName: "lock.fill", localizableKey: .settingsMenuChangePassword))
        settingMenu.append(SettingsMenuItemUIModel(iconName: "doc.text", localizableKey: .settingsMenuPrivacyPolicy))
        settingMenu.append(SettingsMenuItemUIModel(iconName: "doc.richtext", localizableKey: .settingsMenuTermOfUse))
        settingMenu.append(SettingsMenuItemUIModel(iconName: "xmark.shield", localizableKey: .settingsMenuLogout))
        
        self.presenter?.update(menu: settingMenu)
    }
}
