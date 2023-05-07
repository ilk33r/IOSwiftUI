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
    private var isSearchMode: Bool!
    private var imagesStart: Int
    private var totalImageCount: Int?
    
    // MARK: - Initialization Methods
    
    public init() {
        self.imagesStart = 0
        self.isImagesLoading = false
        self.isSearchMode = false
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
    
    @MainActor
    func prepare() async {
        await loadImages()
    }
    
    @MainActor
    func loadImages() async {
        if self.isSearchMode {
            return
        }
        
        if self.isImagesLoading {
            return
        }
        
        if let totalImageCount = self.totalImageCount, self.images.count < totalImageCount {
            self.imagesStart += self.numberOfImagesPerPage
            self.isImagesLoading = true
        } else if totalImageCount == nil {
            self.images.append(contentsOf: self.generateDummyData())
            self.isImagesLoading = true
        } else {
            return
        }
        
        do {
            let response = try await self.interactor.discoverAll(start: self.imagesStart, count: self.numberOfImagesPerPage)
            self.update(discoverResponse: response)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    func resetPaging() {
        self.isSearchMode = false
        self.imagesStart = 0
        self.isImagesLoading = false
        self.totalImageCount = nil
        self.isRefreshing = true
    }
    
    @MainActor
    func searchUser(userName: String) async {
        if userName.isEmpty {
            self.isSearchMode = false
            self.resetPaging()
            await self.loadImages()
            return
        }
        
        self.isSearchMode = true
        
        var images = [SearchUIModel]()
        images.append(contentsOf: self.generateDummyData())
        self.images = images
        
        do {
            let response = try await self.interactor.discoverMember(userName: userName, start: 0, count: 51)
            self.update(discoverResponse: response)
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
    
    // MARK: - Helper Methods
    
    private func generateDummyData() -> [SearchUIModel] {
        var dummyData = [SearchUIModel]()
        
        for _ in 0..<21 {
            dummyData.append(SearchUIModel(imagePublicId: "", userName: "", isDummy: true))
        }
        
        return dummyData
    }
    
    private func update(discoverResponse response: DiscoverImagesResponseModel?) {
        self.totalImageCount = response?.pagination?.total ?? 0
        
        let mappedImages = response?.images?.map({
            SearchUIModel(
                imagePublicId: $0.publicId ?? "",
                userName: $0.userName ?? "",
                isDummy: false
            )
        })
        
        if self.isRefreshing {
            self.images = mappedImages ?? []
        } else {
            var images = self.images.filter { !$0.isDummy }
            images.append(contentsOf: mappedImages ?? [])
            self.images = images
        }
        
        self.thread.runOnMainThread(afterMilliSecond: 250) { [weak self] in
            self?.isImagesLoading = false
            self?.isRefreshing = false
        }
    }
}

#if DEBUG
extension SearchPresenter {
    
    func preparePreviewData() {
        self.images = SearchPreviewData.images
    }
}
#endif
