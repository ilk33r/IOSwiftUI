//
//  SearchTests.swift
//  
//
//  Created by Adnan ilker Ozcan on 7.05.2023.
//

import Foundation
import SwiftUI
import XCTest
@testable import IOSwiftUIInfrastructure
@testable import IOSwiftUIPresentation
@testable import SwiftUISampleAppCommonTests
@testable import SwiftUISampleAppPresentation
@testable import SwiftUISampleAppScreensSearch
@testable import SwiftUISampleAppScreensShared

final class SearchTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_SearchTests" }
    
    // MARK: - Views
    
    private var searchView: SearchView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.searchView = SearchView(entity: nil)
    }
    
    func test01DiscoverAll() async throws {
        // Setup service
        self.setResponse(for: "Discover/DiscoverAll", fileName: "discoverAllSuccess", statusCode: 200)
        self.setResponseHeaders(for: "Discover/DiscoverAll", fileName: "discoverAllSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.searchView, environment: self.environment)
        
        // Wait loading and services
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertFalse(self.searchView.presenter.isRefreshing)
        XCTAssertFalse(self.searchView.presenter.images.isEmpty)
    }
    
    func test02DiscoverMemberImagesError() async throws {
        // Setup service
        self.setResponse(for: "Discover/DiscoverMemberImages", fileName: "discoverMemberImagesError", statusCode: 200)
        self.setResponseHeaders(for: "Discover/DiscoverMemberImages", fileName: "discoverMemberImagesErrorHeaders")
        
        // Call services
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.searchView.presenter.searchUser(userName: "ilker4")
            }
        }
        
        // Wait loading and services
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertFalse(self.searchView.presenter.isRefreshing)
        XCTAssertTrue(self.searchView.presenter.images.isEmpty)
    }
    
    func test03DiscoverMemberImagesSuccess() async throws {
        // Setup service
        self.setResponse(for: "Discover/DiscoverMemberImages", fileName: "discoverMemberImagesSuccess", statusCode: 200)
        self.setResponseHeaders(for: "Discover/DiscoverMemberImages", fileName: "discoverMemberImagesSuccessHeaders")
        
        // Call services
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.searchView.presenter.searchUser(userName: "ilker11")
            }
        }
        
        // Wait loading and services
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertFalse(self.searchView.presenter.isRefreshing)
        XCTAssertEqual(self.searchView.presenter.images.count, 4)
    }
}
