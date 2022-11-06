// 
//  UpdateProfilePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class UpdateProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<IOAppEnvironmentObject>!
    public var interactor: UpdateProfileInteractor!
    public var navigationState: StateObject<UpdateProfileNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var uiModel: UpdateProfileUIModel!
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func hideTabBar() {
        self.interactor.appState.set(bool: true, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
    
    func load() {
        self.uiModel = UpdateProfileUIModel(
            userName: self.interactor.entity.member.userName ?? "",
            name: self.interactor.entity.member.name ?? "",
            surname: self.interactor.entity.member.surname ?? "",
            birthDate: self.interactor.entity.member.birthDate,
            phone: self.interactor.entity.member.phoneNumber ?? ""
        )
    }
    
    func showTabBar() {
        self.interactor.appState.set(bool: false, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
}
