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

final public class SettingsPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SettingsInteractor!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var menu: [SettingsMenuItemUIModel]
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.menu = []
    }
    
    // MARK: - Presenter
    
    func update(menu: [SettingsMenuItemUIModel]) {
        self.menu = menu
    }
}
