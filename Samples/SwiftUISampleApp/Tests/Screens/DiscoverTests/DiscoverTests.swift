//
//  DiscoverTests.swift
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
@testable import SwiftUISampleAppScreensDiscover
@testable import SwiftUISampleAppScreensShared

final class DiscoverTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_DiscoverTests" }
    
    // MARK: - Views
    
    private var discoverView: DiscoverView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.discoverView = DiscoverView(entity: nil)
    }
    
    func test01CheckDiscoverSuccess() async throws {
        // Setup service
        self.setResponse(for: "Discover/Discover", fileName: "discoverSuccess", statusCode: 200)
        self.setResponseHeaders(for: "Discover/Discover", fileName: "discoverSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.discoverView, environment: self.environment)
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertFalse(self.discoverView.presenter.isRefreshing)
        XCTAssertFalse(self.discoverView.presenter.images.isEmpty)
    }
}
