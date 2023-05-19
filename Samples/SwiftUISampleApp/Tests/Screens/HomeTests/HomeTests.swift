//
//  HomeTests.swift
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
@testable import SwiftUISampleAppScreensHome
@testable import SwiftUISampleAppScreensShared

final class HomeTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_HomeTests" }
    
    // MARK: - Views
    
    private var homeView: HomeView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.homeView = HomeView(entity: nil)
    }
    
    func test01ActionSheet() async throws {
        // Instantiate controller
        self.setupView(view: self.homeView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Show action sheet
        self.homeView.presenter.showActionSheet()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Tests
        XCTAssertNotNil(self.homeView.presenter.actionSheetData)
    }
    
    func test02UploadImage() async throws {
        // Setup service
        self.setResponse(for: "MemberImages/AddMemberImage", fileName: "addMemberImageSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberImages/AddMemberImage", fileName: "addMemberImageSuccessHeaders")

        // Instantiate controller
        self.setupView(view: self.homeView, environment: self.environment)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.homeView.presenter.uploadImage(image: UIImage(systemName: "chevron.left")!)
            }
        }
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Tests
        XCTAssertNotNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
    }
}
