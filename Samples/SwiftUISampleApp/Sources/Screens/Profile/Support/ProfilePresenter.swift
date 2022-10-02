// 
//  ProfilePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUI

final class ProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Environment = SampleAppEnvironment
    typealias Interactor = ProfileInteractor
    
    var environment: EnvironmentObject<SampleAppEnvironment>!
    var interactor: ProfileInteractor!
    
    // MARK: - Publisher
    
    @Published var member: MemberModel?
    var profilePictureData: Data?
    
    // MARK: - Initialization Methods
    
    init() {
    }
    
    // MARK: - Presenter
    
    func update(member: MemberModel?, profilePictureData: Data?) {
        self.profilePictureData = profilePictureData
        self.member = member
    }
}
