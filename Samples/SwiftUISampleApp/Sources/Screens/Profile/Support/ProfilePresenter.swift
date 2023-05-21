// 
//  ProfilePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class ProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: ProfileInteractor!
    public var navigationState: StateObject<ProfileNavigationState>!
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Constants
    
    private let numberOfImagesPerPage = 10
    
    // MARK: - Publics
    
    var profilePictureUpdatedPublisher: AnyPublisher<Bool?, Never> {
        self.interactor.eventProcess.bool(forType: .profilePictureUpdated)
    }
    
    // MARK: - Publisher
    
    @Published var profileUIModel: ProfileUIModel?
    @Published private(set) var chatEntity: ChatEntity?
    @Published private(set) var images: [String]!
    
    // MARK: - Privates
    
    private var imagesStart: Int!
    private var isImagesLoading: Bool!
    private var totalImageCount: Int?
    private var member: MemberModel?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.images = []
    }
    
    // MARK: - Presenter
    
    @MainActor
    func prepare() async {
        do {
            let member = try await self.interactor.getMember()
            self.updateMember(member: member)
            self.interactor.eventProcess.set(bool: false, forType: .profilePictureUpdated)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func createInbox() async {
        do {
            let inbox = try await self.interactor.createInbox(memberID: self.member?.id ?? 0)
            guard let inbox else { return }
            
            let messagesResponse = try await self.interactor.getMessages(memberID: self.member?.id ?? 0, inboxID: inbox.inboxID ?? 0)
            self.chatEntity = ChatEntity(
                toMemberId: self.member?.id ?? 0,
                inbox: inbox,
                messages: messagesResponse.messages ?? [],
                pagination: messagesResponse.pagination ?? PaginationModel()
            )
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func followMember() async {
        do {
            let member = try await self.interactor.followMember(memberID: self.member?.id ?? 0)
            self.updateMember(member: member)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func loadImages() async {
        if self.isImagesLoading {
            return
        }
        
        if let totalImageCount = self.totalImageCount, self.images.count < totalImageCount {
            self.imagesStart += self.numberOfImagesPerPage
            self.isImagesLoading = true
        } else if totalImageCount == nil {
            self.isImagesLoading = true
        } else {
            return
        }
        
        do {
            let imagesResponse = try await self.interactor.getImages(start: self.imagesStart, count: self.numberOfImagesPerPage)
            self.totalImageCount = imagesResponse.pagination?.total ?? 0
            let mappedImages = imagesResponse.images?.map({ $0.publicId ?? "" })
            
            self.images.append(contentsOf: mappedImages ?? [])
            self.thread.runOnMainThread(afterMilliSecond: 250) { [weak self] in
                self?.isImagesLoading = false
            }
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    @MainActor
    func navigateToFriends() async {
        do {
            let friends = try await self.interactor.getFriends()
            self.navigationState.wrappedValue.friendsEntity = FriendsEntity(friends: friends)
            self.navigationState.wrappedValue.navigateToFriends = true
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    func navigateToLocation(isPresented: Binding<Bool>) {
        guard let locationName = self.member?.locationName else { return }
        guard let locationLatitude = self.member?.locationLatitude else { return }
        guard let locationLongitude = self.member?.locationLongitude else { return }
        
        let userLocationEntity = UserLocationEntity(
            isEditable: false,
            isPresented: isPresented,
            locationName: Binding.constant(locationName),
            locationLatitude: Binding.constant(locationLatitude),
            locationLongitude: Binding.constant(locationLongitude)
        )
        
        self.navigationState.wrappedValue.mapView = IORouterUtilities.route(ProfileRouters.self, .userLocation(entity: userLocationEntity))
        self.navigationState.wrappedValue.navigateToMap = true
    }
    
    func navigateToSettings() {
        guard let member = self.member else { return }
        
        self.navigationState.wrappedValue.settingsEntity = SettingsEntity(member: member)
        self.navigationState.wrappedValue.navigateToSettings = true
    }
    
    @MainActor
    func unFollowMember() async {
        do {
            let member = try await self.interactor.unFollowMember(memberID: self.member?.id ?? 0)
            self.updateMember(member: member)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    // MARK: - Helper Methods
    
    private func updateMember(member: MemberModel?) {
        self.member = member
        self.profileUIModel = ProfileUIModel(
            name: (member?.name ?? "").uppercased(),
            nameSurname: String(format: "%@ %@", member?.name ?? "", member?.surname ?? ""),
            locationName: member?.locationName ?? "",
            isOwnProfile: self.interactor.entity.userName == nil ? true : false,
            isFollowing: member?.isFollowing ?? false,
            profilePicturePublicId: member?.profilePicturePublicId
        )
    }
}

#if DEBUG
extension ProfilePresenter {
    
    func prepareForPreview() {
        let member = MemberModel()
        member.id = 1
        member.userName = "ilker0"
        member.birthDate = Date()
        member.email = "ilker0@ilker.com"
        member.name = "İlker"
        member.surname = "ÖZCAN"
        member.locationName = "Beşiktaş"
        member.isFollowing = true

        self.member = member
        self.profileUIModel = ProfileUIModel(
            name: (member.name ?? "").uppercased(),
            nameSurname: String(format: "%@ %@", member.name ?? "", member.surname ?? ""),
            locationName: member.locationName ?? "",
            isOwnProfile: self.interactor.entity.userName == nil ? true : false,
            isFollowing: member.isFollowing ?? false,
            profilePicturePublicId: member.profilePicturePublicId
        )
        
        self.images = ProfilePreviewData.previewImages
    }
}
#endif
