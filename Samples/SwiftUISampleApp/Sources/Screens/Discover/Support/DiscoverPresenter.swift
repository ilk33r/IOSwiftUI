// 
//  DiscoverPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

final public class DiscoverPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: DiscoverInteractor!
    public var navigationState: StateObject<DiscoverNavigationState>!
    
    // MARK: - Constants
    
    private let numberOfImagesPerPage = 10
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Publisher
    
    @Published var stories: [StoryItemUIModel]?
    @Published private(set) var images: [DiscoverUIModel]!
    @Published private(set) var isRefreshing: Bool!
    
    // MARK: - Privates
    
    private var allStories: DiscoverStoriesResponseModel?
    private var imagesStart: Int!
    private var isImagesLoading: Bool!
    private var totalImageCount: Int?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.images = []
        self.isRefreshing = false
    }
    
    // MARK: - Presenter
    
    @MainActor
    func prepare() async {
        async let imageStatus = self.loadImages(showIndicator: true)
        async let stories = self.interactor.stories()
        
        let allData = await (imageStatus, stories)
        self.allStories = allData.1
        self.stories = self.allStories?
            .stories?
            .map {
                StoryItemUIModel(
                    userProfilePicturePublicId: $0.images?.first?.userProfilePicturePublicId,
                    userName: $0.images?.first?.userName
                )
            }
    }
    
    @MainActor
    @discardableResult
    func loadImages(showIndicator: Bool) async -> Bool {
        if self.isImagesLoading {
            return false
        }
        
        if let totalImageCount = self.totalImageCount, self.images.count < totalImageCount {
            self.imagesStart += self.numberOfImagesPerPage
            self.isImagesLoading = true
        } else if totalImageCount == nil {
            if !self.isRefreshing {
                self.showIndicator()
            }
            
            self.isImagesLoading = true
        } else {
            return false
        }
        
        do {
            let response = try await self.interactor.discover(
                start: self.imagesStart,
                count: self.numberOfImagesPerPage
            )
            self.update(discoverResponse: response)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
        
        return true
    }
    
    func resetPaging() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.totalImageCount = nil
        self.isRefreshing = true
    }
    
    // MARK: - Helper Methods
    
    private func update(discoverResponse response: DiscoverImagesResponseModel?) {
        if !self.isRefreshing {
            self.hideIndicator()
        }
        
        self.totalImageCount = response?.pagination?.total ?? 0
        
        let relativeDate = Date()
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.dateTimeStyle = .numeric
        
        let mappedImages = response?.images?.map({
            DiscoverUIModel(
                imagePublicId: $0.publicId ?? "",
                userName: $0.userName ?? "",
                userNameAndSurname: $0.userNameAndSurname ?? "",
                userAvatarPublicId: $0.userProfilePicturePublicId ?? "",
                messageTime: dateFormatter.localizedString(for: $0.createDate ?? Date(), relativeTo: relativeDate)
            )
        })
        
        if self.isRefreshing {
            self.images = mappedImages ?? []
        } else {
            self.images.append(contentsOf: mappedImages ?? [])
        }
        
        self.thread.runOnMainThread(afterMilliSecond: 250) { [weak self] in
            self?.isImagesLoading = false
            self?.isRefreshing = false
        }
    }
}

#if DEBUG
extension DiscoverPresenter {
    
    func prepareForPreview() {
        self.images = DiscoverPreviewData.previewData
    }
}
#endif
