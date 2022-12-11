// 
//  RegisterProfilePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class RegisterProfilePresenter: IOPresenterable {
    
    // MARK: - Defs
    
    struct ActionSheetData: Identifiable {
        
        let id = UUID()
    }
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: RegisterProfileInteractor!
    public var navigationState: StateObject<RegisterProfileNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var actionSheetData: ActionSheetData?
    @Published private(set) var profilePictureImage: UIImage?
    @Published private(set) var userEmail: String
    @Published private(set) var userName: String
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.userEmail = ""
        self.userName = ""
    }
    
    // MARK: - Presenter
    
    func navigateToHome() {
        self.environment.wrappedValue.isLoggedIn = true
    }
    
    func prepare() {
        self.userEmail = self.interactor.entity.email
        self.userName = self.interactor.entity.userName
    }
    
    func registerCompleted() {
        if let profilePictureImage = self.profilePictureImage {
            self.interactor.uploadProfilePicture(image: profilePictureImage)
            return
        }
        
        self.hideIndicator()
        self.navigateToHome()
    }
    
    func showActionSheet() {
        self.actionSheetData = ActionSheetData()
    }
    
    func updateProfilePicture(image: UIImage) {
        self.profilePictureImage = image
    }
}
