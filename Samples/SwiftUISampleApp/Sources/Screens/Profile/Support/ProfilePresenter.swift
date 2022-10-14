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
    
    // MARK: - Constants
    
    private let numberOfImagesPerPage = 10
    
    // MARK: - Publisher
    
    @Published private(set) var member: MemberModel?
    @Published private(set) var images: [String]!
    
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
            self.interactor.getImages(start: self.imagesStart, count: self.numberOfImagesPerPage)
        } else if totalImageCount == nil {
            self.isImagesLoading = true
            self.interactor.getImages(start: self.imagesStart, count: self.numberOfImagesPerPage)
        }
    }
    
    func update(member: MemberModel?) {
        self.member = member
    }
    
    func update(imagesResponse: MemberImagesResponseModel?) {
        self.totalImageCount = imagesResponse?.pagination?.total ?? 0
        
        let mappedImages = imagesResponse?.images?.map({ $0.publicId ?? "" })
        self.images.append(contentsOf: mappedImages ?? [])
        self.isImagesLoading = false
    }
}
