//
//  RegisterTests.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.05.2023.
//

import Foundation
import SwiftUI
import XCTest
@testable import IOSwiftUIInfrastructure
@testable import IOSwiftUIPresentation
@testable import SwiftUISampleAppCommonTests
@testable import SwiftUISampleAppPresentation
@testable import SwiftUISampleAppScreensRegister
@testable import SwiftUISampleAppScreensShared

final class RegisterTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_RegisterTests" }
    
    // MARK: - Views
    
    private var registerView: RegisterView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.registerView = RegisterView(entity: nil)
    }
    
    func test01CheckMemberSuccess() async throws {
        // Setup service
        self.setResponse(for: "MemberRegister/CheckMember", fileName: "checkMemberSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberRegister/CheckMember", fileName: "checkMemberSuccessHeaders")
        
        // Logout user
        self.localStorage.remove(type: .userToken)
        
        // Instantiate controller
        self.setupView(view: self.registerView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.registerView.presenter.checkMember(email: "ilker5@ilker.com")
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
        XCTAssertTrue(self.registerView.presenter.navigationState.wrappedValue.navigateToUserName)
    }
    
    func test02CheckMemberError() async throws {
        // Setup service
        self.setResponse(for: "MemberRegister/CheckMember", fileName: "checkMemberError", statusCode: 200)
        self.setResponseHeaders(for: "MemberRegister/CheckMember", fileName: "checkMemberErrorHeaders")
        
        // Logout user
        self.localStorage.remove(type: .userToken)
        
        // Instantiate controller
        self.setupView(view: self.registerView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.registerView.presenter.checkMember(email: "ilker5@ilker.com")
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
        XCTAssertFalse(self.registerView.presenter.navigationState.wrappedValue.navigateToUserName)
    }
}
