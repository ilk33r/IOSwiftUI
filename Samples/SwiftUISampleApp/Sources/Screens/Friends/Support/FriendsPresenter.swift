// 
//  FriendsPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class FriendsPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: FriendsInteractor!
    public var navigationState: StateObject<FriendsNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var followers: [FriendUIModel]
    @Published private(set) var followersCount: Int
    @Published private(set) var followings: [FriendUIModel]
    @Published private(set) var followingsCount: Int
    
    // MARK: - Privates
    
    private var friendsResponse: MemberFriendsResponseModel?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.followers = []
        self.followersCount = 0
        self.followings = []
        self.followingsCount = 0
    }
    
    // MARK: - Presenter
    
    func update(friendsResponse: MemberFriendsResponseModel) {
        self.friendsResponse = friendsResponse
        
        let followers = friendsResponse.followers ?? []
        self.followersCount = followers.count
        self.followers = followers.map {
            FriendUIModel(
                userName: $0.userName ?? "",
                userNameAndSurname: $0.userNameAndSurname ?? "",
                locationName: $0.locationName ?? "",
                locationLatitude: $0.locationLatitude ?? 0,
                locationLongitude: $0.locationLongitude ?? 0,
                profilePicturePublicId: $0.profilePicturePublicId ?? ""
            )
        }
        
        let followings = friendsResponse.followings ?? []
        self.followingsCount = followings.count
        self.followings = followings.map {
            FriendUIModel(
                userName: $0.userName ?? "",
                userNameAndSurname: $0.userNameAndSurname ?? "",
                locationName: $0.locationName ?? "",
                locationLatitude: $0.locationLatitude ?? 0,
                locationLongitude: $0.locationLongitude ?? 0,
                profilePicturePublicId: $0.profilePicturePublicId ?? ""
            )
        }
    }
    
    func navigate(toUser userName: String) {
        navigationState.wrappedValue.profileEntity = ProfileEntity(userName: userName)
        navigationState.wrappedValue.navigateToProfile = true
    }
}
