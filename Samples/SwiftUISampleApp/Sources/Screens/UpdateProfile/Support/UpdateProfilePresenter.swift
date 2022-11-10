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
import SwiftUISampleAppPresentation

final public class UpdateProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: UpdateProfileInteractor!
    public var navigationState: StateObject<UpdateProfileNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var uiModel: UpdateProfileUIModel!
    @Published var navigateToBack: Bool!
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.navigateToBack = false
    }
    
    // MARK: - Presenter
    
    func hideTabBar() {
        self.interactor.appState.set(bool: true, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
    
    func load() {
        self.uiModel = UpdateProfileUIModel(
            userName: self.interactor.entity.member.userName ?? "",
            email: self.interactor.entity.member.email ?? "",
            name: self.interactor.entity.member.name ?? "",
            surname: self.interactor.entity.member.surname ?? "",
            birthDate: self.interactor.entity.member.birthDate,
            phone: self.interactor.entity.member.phoneNumber ?? "",
            locationName: self.interactor.entity.member.locationName ?? "",
            locationLatitude: self.interactor.entity.member.locationLatitude,
            locationLongitude: self.interactor.entity.member.locationLongitude
        )
    }
    
    func showTabBar() {
        self.interactor.appState.set(bool: false, forType: .tabBarIsHidden)
        NotificationCenter.default.post(name: .tabBarVisibilityChangeNotification, object: nil)
    }
    
    func updateSuccess() {
        self.showAlert(.updateProfileSuccessMessage) { [weak self] _ in
            self?.navigateToBack = true
        }
    }
}
