// 
//  SearchPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation

final public class SearchPresenter: IOPresenterable {
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: SearchInteractor!
    public var navigationState: StateObject<SearchNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var images: [SearchUIModel]!
    @Published private(set) var isRefreshing: Bool!
    @Published private(set) var keyboardPublisher: AnyPublisher<Bool, Never>
    
    // MARK: - Privates
    
    private let numberOfImagesPerPage = 30
    
    private var isImagesLoading: Bool!
    private var imagesStart: Int
    private var totalImageCount: Int?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.images = []
        self.isRefreshing = false
        self.keyboardPublisher = Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardDidHideNotification)
                    .map { _ in false }
            )
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Presenter
    
    func loadImages(showIndicator: Bool) {
        if self.isImagesLoading {
            return
        }
        
        if let totalImageCount = self.totalImageCount, self.images.count < totalImageCount {
            self.imagesStart += self.numberOfImagesPerPage
            self.isImagesLoading = true
            self.interactor.discoverAll(start: self.imagesStart, count: self.numberOfImagesPerPage)
        } else if totalImageCount == nil {
            if !self.isRefreshing {
                self.showIndicator()
            }
            
            self.isImagesLoading = true
            self.interactor.discoverAll(start: self.imagesStart, count: self.numberOfImagesPerPage)
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
        
        let mappedImages = response?.images?.map({
            SearchUIModel(
                imagePublicId: $0.publicId ?? "",
                userName: $0.userName ?? ""
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
