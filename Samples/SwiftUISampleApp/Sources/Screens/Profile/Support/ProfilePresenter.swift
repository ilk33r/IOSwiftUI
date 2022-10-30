// 
//  ProfilePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

final public class ProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: ProfileInteractor!
    
    // MARK: - Constants
    
    private let numberOfImagesPerPage = 10
    
    // MARK: - Publisher
    
    @Published private(set) var chatEntity: ChatEntity?
    @Published private(set) var images: [String]!
    @Published private(set) var profileUIModel: ProfileUIModel?
    
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
    
    func createInbox() {
        self.interactor.createInbox(memberID: self.member?.id ?? 0)
    }
    
    func loadImages() {
        if self.isImagesLoading {
            return
        }
        
        if let totalImageCount = self.totalImageCount, self.images.count < totalImageCount {
            self.imagesStart += self.numberOfImagesPerPage
            self.isImagesLoading = true
            self.interactor.getImages(start: self.imagesStart, count: self.numberOfImagesPerPage)
        } else if totalImageCount == nil {
            self.isImagesLoading = true
            self.interactor.getImages(start: self.imagesStart, count: self.numberOfImagesPerPage)
        }
    }
    
    func navigate(toMemberId: Int, inbox: InboxModel?) {
        guard let inbox = inbox else { return }
        self.chatEntity = ChatEntity(toMemberId: toMemberId, inbox: inbox)
    }
    
    func set(member: MemberModel?) {
        self.member = member
    }
    
    func update(member: MemberModel?, isOwnProfile: Bool) {
        self.profileUIModel = ProfileUIModel(
            name: (member?.name ?? "").uppercased(),
            nameSurname: String(format: "%@ %@", member?.name ?? "", member?.surname ?? ""),
            locationName: member?.locationName ?? "",
            isOwnProfile: isOwnProfile,
            isFollowing: member?.isFollowing ?? false,
            profilePicturePublicId: member?.profilePicturePublicId
        )
    }
    
    func update(imagesResponse: MemberImagesResponseModel?) {
        self.totalImageCount = imagesResponse?.pagination?.total ?? 0
        
        let mappedImages = imagesResponse?.images?.map({ $0.publicId ?? "" })
        self.images.append(contentsOf: mappedImages ?? [])
        self.isImagesLoading = false
    }
}
