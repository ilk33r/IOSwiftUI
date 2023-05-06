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
    
    func testAnonymouseUserSuccess() async throws {
        self.localStorage.remove(type: .userToken)
        self.setResponse(for: "HandshakeDefault/Index", fileName: "handshakeSuccess")
        self.setResponseHeaders(for: "HandshakeDefault/Index", fileName: "handshakeSuccessHeaders")
        self.setResponseStatusCode(for: "HandshakeDefault/Index", statusCode: 200)
        
        self.setupView(view: self.splashView, environment: self.environment)
        
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Check first service
        XCTAssertNotNil(self.environment.alertData)
        XCTAssertTrue(self.environment.showLoading)
        XCTAssertNil(self.appState.object(forType: .aesKey))
        XCTAssertNil(self.appState.object(forType: .aesIV))
        XCTAssertFalse(self.splashView.presenter.showButtons)
    }
}
