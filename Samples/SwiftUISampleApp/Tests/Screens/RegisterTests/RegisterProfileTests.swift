//
//  RegisterProfileTests.swift
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

final class RegisterProfileTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_RegisterTests" }
    
    // MARK: - Views
    
    private var registerView: RegisterProfileView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.registerView = RegisterProfileView(
            entity: RegisterProfileEntity(
                email: "ilker5@ilker.com",
                password: "12345678",
                userName: "ilker5"
            )
        )
    }
    
    func test01RegisterMemberSuccess() async throws {
        // Setup service
        self.setResponse(for: "MemberRegister/Register", fileName: "registerSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberRegister/Register", fileName: "registerSuccessHeaders")
        self.setResponse(for: "MemberLogin/Authenticate", fileName: "authenticateSuccess", statusCode: 200)
        self.setResponseHeaders(for: "MemberLogin/Authenticate", fileName: "authenticateSuccessHeaders")
        
        // Logout user
        self.localStorage.remove(type: .userToken)
        
        // Instantiate controller
        self.setupView(view: self.registerView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.registerView.presenter.createProfile(
                    birthDate: Date(),
                    name: "İlker",
                    surname: "Özcan",
                    locationName: "Avcılar",
                    locationLatitude: 41.066110000000002,
                    locationLongitude: 28.71631,
                    phoneNumber: "905331234567"
                )
            }
        }
        
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
