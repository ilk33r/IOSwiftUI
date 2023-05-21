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
    
    @Published private(set) var uiModel: UpdateProfileUIModel!
    @Published private(set) var navigateToBack: Bool!
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.navigateToBack = false
    }
    
    // MARK: - Presenter
    
    func hideTabBar() {
        self.interactor.eventProcess.set(bool: false, forType: .tabBarVisibility)
    }
    
    func prepare() {
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
        self.interactor.eventProcess.set(bool: true, forType: .tabBarVisibility)
    }
    
    @MainActor
    func updateMember(
        userName: String?,
        birthDate: Date?,
        email: String?,
        name: String?,
        surname: String?,
        locationName: String?,
        locationLatitude: Double?,
        locationLongitude: Double?,
        phoneNumber: String?
    ) async {
        do {
            try await self.interactor.updateMember(
                userName: userName,
                birthDate: birthDate,
                email: email,
                name: name,
                surname: surname,
                locationName: locationName,
                locationLatitude: locationLatitude,
                locationLongitude: locationLongitude,
                phoneNumber: phoneNumber
            )
            
            await self.showAlertAsync {
                IOAlertData(title: nil, message: .successMessage, buttons: [.commonOk])
            }
            
            self.navigateToBack = true
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
