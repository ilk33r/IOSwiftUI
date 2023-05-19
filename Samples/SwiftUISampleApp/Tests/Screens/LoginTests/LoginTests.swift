//
//  LoginTests.swift
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
@testable import SwiftUISampleAppScreensLogin
@testable import SwiftUISampleAppScreensShared

final class LoginTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_LoginTests" }
    
    // MARK: - Views
    
    private var loginView: LoginView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.loginView = LoginView(entity: nil)
    }
    
    func test01CheckMemberSuccess() async throws {
        // Setup service
        self.setResponse(for: "MemberRegister/CheckMember", fileName: "checkMemberSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberRegister/CheckMember", fileName: "checkMemberSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.loginView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.loginView.presenter.checkMember(email: "ilker4@ilker.com")
            }
        }
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertTrue(self.loginView.presenter.navigationState.wrappedValue.navigateToPassword)
    }
    
    func test02CheckError() async throws {
        // Setup service
        self.setResponse(for: "MemberRegister/CheckMember", fileName: "checkMemberError", statusCode: 200)
        self.setResponseHeaders(for: "MemberRegister/CheckMember", fileName: "checkMemberErrorHeaders")
        
        // Instantiate controller
        self.setupView(view: self.loginView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.loginView.presenter.checkMember(email: "ilker4@ilker.com")
            }
        }
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNotNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertFalse(self.loginView.presenter.navigationState.wrappedValue.navigateToPassword)
    }
}
