// 
//  DiscoverPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
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
    
    // MARK: - Publisher
    
    @Published var images: [DiscoverUIModel]!
    
    // MARK: - Privates
    
    private var imagesStart: Int!
    private var isImagesLoading: Bool!
    private var totalImageCount: Int?
    
    // MARK: - Initialization Methods
    
    init() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.images = []
    }
    
    // MARK: - Presenter
    
    func loadImages() {
        if self.isImagesLoading {
            return
        }
        
        if let totalImageCount = self.totalImageCount, self.images.count < totalImageCount {
            self.imagesStart += self.numberOfImagesPerPage
            self.isImagesLoading = true
            self.interactor.discover(start: self.imagesStart, count: self.numberOfImagesPerPage)
        } else if totalImageCount == nil {
            self.showIndicator()
            self.isImagesLoading = true
            self.interactor.discover(start: self.imagesStart, count: self.numberOfImagesPerPage)
        }
    }
    
    func update(discoverResponse response: DiscoverImagesResponseModel?) {
        if self.totalImageCount == nil {
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
        self.images.append(contentsOf: mappedImages ?? [])
        self.isImagesLoading = false
    }
}
