//
//  SplashTests.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.05.2023.
//

import Foundation
import SwiftUI
import XCTest
@testable import IOSwiftUIInfrastructure
@testable import IOSwiftUIPresentation
@testable import SwiftUISampleAppCommonTests
@testable import SwiftUISampleAppPresentation
@testable import SwiftUISampleAppScreensSplash
@testable import SwiftUISampleAppScreensShared

final class SplashTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_SplashTests" }
    
    // MARK: - Views
    
    private var splashView: SplashView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.splashView = SplashView(entity: nil)
    }
    
    func test01AnonymouseUserSuccess() async throws {
        // Setup service
        self.setResponse(for: "HandshakeDefault/Index", fileName: "handshakeSuccess", statusCode: 200)
        self.setResponseHeaders(for: "HandshakeDefault/Index", fileName: "handshakeSuccessHeaders")
        
        // Logout user
        self.localStorage.remove(type: .userToken)
        
        // Instantiate controller
        self.setupView(view: self.splashView, environment: self.environment)
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertTrue(self.splashView.presenter.showButtons)
    }
    
    func test02LoggedInUserSuccess() async throws {
        // Setup service
        self.setResponse(for: "HandshakeDefault/Index", fileName: "handshakeSuccess", statusCode: 200)
        self.setResponseHeaders(for: "HandshakeDefault/Index", fileName: "handshakeSuccessHeaders")
        
        self.setResponse(for: "MemberLogin/CheckToken", fileName: "checkTokenSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberLogin/CheckToken", fileName: "checkTokenSuccessHeaders")
        
        // Log in user
        self.localStorage.set(string: "08167c40-aec1-4c9a-9fdc-1a1461f5b44a-11", forType: .userToken)
        
        // Instantiate controller
        self.setupView(view: self.splashView, environment: self.environment)
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall(count: 2)
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertEqual(self.environment.appScreen, .loggedIn)
    }
}
