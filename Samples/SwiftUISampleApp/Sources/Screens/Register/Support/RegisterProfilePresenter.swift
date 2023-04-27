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
import IOSwiftUISupportNFC
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation

final public class RegisterProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: RegisterProfileInteractor!
    public var navigationState: StateObject<RegisterProfileNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published var actionSheetData: IOAlertData?
    @Published private(set) var birthDate: String?
    @Published private(set) var locationName: String
    @Published private(set) var name: String
    @Published private(set) var profilePictureImage: UIImage?
    @Published private(set) var surname: String
    @Published private(set) var userEmail: String
    @Published private(set) var userName: String
    
    // MARK: - Privates
    
    private var mrzFullString: String?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.locationName = ""
        self.name = ""
        self.surname = ""
        self.userEmail = ""
        self.userName = ""
    }
    
    // MARK: - Presenter
    
    func prepare() {
        self.userEmail = self.interactor.entity.email
        self.userName = self.interactor.entity.userName
        
        if let nfcDG1 = self.interactor.appState.object(forType: .registerNFCDG1) as? IOISO7816DG1Model {
            self.surname = nfcDG1.surname
            self.name = nfcDG1.name
            self.mrzFullString = nfcDG1.mrzFullString
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyMMdd"
            if let birthDate = dateFormatter.date(from: nfcDG1.dateOfBirth) {
                dateFormatter.dateFormat = CommonConstants.pickerDateFormat
                self.birthDate = dateFormatter.string(from: birthDate)
            }
        }
        
        if
            let nfcDG2 = self.interactor.appState.object(forType: .registerNFCDG2) as? IOISO7816DG2Model,
            let biometricData = nfcDG2.biometricDatas.first {
            self.profilePictureImage = biometricData.image
        }
        
        if let nfcDG11 = self.interactor.appState.object(forType: .registerNFCDG11) as? IOISO7816DG11Model {
            self.locationName = nfcDG11.placeOfBirth
        }
    }
    
    func showActionSheet() {
        self.actionSheetData = IOAlertData(
            title: .cameraActionsTitle,
            message: "",
            buttons: [
                .cameraActionsTakePhoto,
                .cameraActionsChoosePhoto,
                .commonCancel
            ]
        ) { [weak self] index in
            if index == 2 { return }
            
            if index == 0 {
                self?.navigationState.wrappedValue.navigateToCamera = true
            } else if index == 1 {
                self?.navigationState.wrappedValue.navigateToPhotoLibrary = true
            }
        }
    }
    
    func updateProfilePicture(image: UIImage) {
        self.profilePictureImage = image
    }
    
    @MainActor
    func createProfile(
        birthDate: Date?,
        name: String?,
        surname: String?,
        locationName: String?,
        locationLatitude: Double?,
        locationLongitude: Double?,
        phoneNumber: String?
    ) async {
        do {
            try await self.interactor.createProfile(
                birthDate: birthDate,
                name: name,
                surname: surname,
                locationName: locationName,
                locationLatitude: locationLatitude,
                locationLongitude: locationLongitude,
                phoneNumber: phoneNumber,
                mrzFullString: self.mrzFullString
            )
            
            if let profilePictureImage = self.profilePictureImage {
                await self.interactor.uploadProfilePicture(image: profilePictureImage)
            }
            
            self.hideIndicator()
            self.environment.wrappedValue.appScreen = .loggedIn
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
