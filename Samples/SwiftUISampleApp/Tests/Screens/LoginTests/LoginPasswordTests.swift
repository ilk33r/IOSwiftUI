//
//  LoginPasswordTests.swift
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

final class LoginPasswordTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_LoginTests" }
    
    // MARK: - Views
    
    private var loginPasswordView: LoginPasswordView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.loginPasswordView = LoginPasswordView(
            entity: LoginPasswordEntity(
                email: "ilker4@ilker.com"
            )
        )
    }
    
    func testAuthenticateSuccess() async throws {
        // Setup service
        self.setResponse(for: "MemberLogin/Authenticate", fileName: "authenticateSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberLogin/Authenticate", fileName: "authenticateSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.loginPasswordView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Setup properties
        self.appState.set(object: Data(secureRandomizedData: 16), forType: .aesIV)
        self.appState.set(object: Data(secureRandomizedData: 32), forType: .aesKey)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.loginPasswordView.presenter.login(password: "12345678")
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
        XCTAssertEqual(self.environment.appScreen, .loggedIn)
    }
    
    func testAuthenticateError() async throws {
        // Setup service
        self.setResponse(for: "MemberLogin/Authenticate", fileName: "authenticateError", statusCode: 200)
        self.setResponseHeaders(for: "MemberLogin/Authenticate", fileName: "authenticateErrorHeaders")
        
        // Instantiate controller
        self.setupView(view: self.loginPasswordView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Setup properties
        self.appState.set(object: Data(secureRandomizedData: 16), forType: .aesIV)
        self.appState.set(object: Data(secureRandomizedData: 32), forType: .aesKey)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.loginPasswordView.presenter.login(password: "12345678")
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
        XCTAssertNotEqual(self.environment.appScreen, .loggedIn)
    }
}
