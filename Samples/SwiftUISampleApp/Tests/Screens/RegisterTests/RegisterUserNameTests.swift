//
//  RegisterUserNameTests.swift
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

final class RegisterUserNameTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_RegisterTests" }
    
    // MARK: - Views
    
    private var registerUserNameView: RegisterUserNameView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.registerUserNameView = RegisterUserNameView(
            entity: RegisterUserNameEntity(
                email: "ilker5@ilker.com"
            )
        )
    }
    
    func test01CheckMemberNameSuccess() async throws {
        // Setup service
        self.setResponse(for: "MemberRegister/CheckMemberUserName", fileName: "checkMemberUserNameSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberRegister/CheckMemberUserName", fileName: "checkMemberUserNameSuccessHeaders")
        
        // Logout user
        self.localStorage.remove(type: .userToken)
        
        // Instantiate controller
        self.setupView(view: self.registerUserNameView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.registerUserNameView.presenter.checkUserName(userName: "ilker5")
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
        XCTAssertTrue(self.registerUserNameView.presenter.navigationState.wrappedValue.navigateToCreatePassword)
    }
    
    func test02CheckMemberError() async throws {
        // Setup service
        self.setResponse(for: "MemberRegister/CheckMemberUserName", fileName: "checkMemberUserNameError", statusCode: 200)
        self.setResponseHeaders(for: "MemberRegister/CheckMemberUserName", fileName: "checkMemberUserNameErrorHeaders")
        
        // Logout user
        self.localStorage.remove(type: .userToken)
        
        // Instantiate controller
        self.setupView(view: self.registerUserNameView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.registerUserNameView.presenter.checkUserName(userName: "ilker5")
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
        XCTAssertFalse(self.registerUserNameView.presenter.navigationState.wrappedValue.navigateToCreatePassword)
    }
}
