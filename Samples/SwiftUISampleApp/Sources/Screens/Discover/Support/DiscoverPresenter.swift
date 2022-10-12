// 
//  DiscoverPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation
import SwiftUI

final class DiscoverPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Environment = SampleAppEnvironment
    typealias Interactor = DiscoverInteractor
    
    var environment: EnvironmentObject<SampleAppEnvironment>!
    var interactor: DiscoverInteractor!
    
    // MARK: - Constants
    
    private let numberOfImagesPerPage = 10
    
    // MARK: - DI
    
    @IOInstance private var thread: IOThreadImpl
    
    // MARK: - Publisher
    
    @Published var images: [DiscoverUIModel]!
    @Published var isRefreshing: Bool!
    
    // MARK: - Privates
    
    private var imagesStart: Int!
    private var isImagesLoading: Bool!
    private var totalImageCount: Int?
    
    // MARK: - Initialization Methods
    
    init() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.images = []
        self.isRefreshing = false
    }
    
    // MARK: - Presenter
    
    func loadImages(showIndicator: Bool) {
        if self.isImagesLoading {
            return
        }
        
        if let totalImageCount = self.totalImageCount, self.images.count < totalImageCount {
            self.imagesStart += self.numberOfImagesPerPage
            self.isImagesLoading = true
            self.interactor.discover(start: self.imagesStart, count: self.numberOfImagesPerPage)
        } else if totalImageCount == nil {
            if !self.isRefreshing {
                self.showIndicator()
            }
            
            self.isImagesLoading = true
            self.interactor.discover(start: self.imagesStart, count: self.numberOfImagesPerPage)
        }
    }
    
    func resetPaging() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.totalImageCount = nil
        self.isRefreshing = true
    }
    
    func update(discoverResponse response: DiscoverImagesResponseModel?) {
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
        
        self.isImagesLoading = false
        
        self.thread.runOnMainThread(afterMilliSecond: 250) { [weak self] in
            self?.isRefreshing = false
        }
    }
}
