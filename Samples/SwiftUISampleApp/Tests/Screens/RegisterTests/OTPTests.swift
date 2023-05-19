//
//  OTPTests.swift
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
@testable import SwiftUISampleAppScreensSendOTP
@testable import SwiftUISampleAppScreensShared

final class OTPTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_RegisterTests" }
    
    // MARK: - Views
    
    private var otpView: SendOTPView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.otpView = SendOTPView(
            entity: SendOTPEntity(
                isPresented: Binding.constant(true),
                isOTPValidated: Binding.constant(false),
                phoneNumber: "905331234567"
            )
        )
    }
    
    func test01SendOTPSuccess() async throws {
        // Setup service
        self.setResponse(for: "OTP/Send", fileName: "otpSendSuccess", statusCode: 200)
        self.setResponseHeaders(for: "OTP/Send", fileName: "otpSendSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.otpView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertEqual(self.otpView.presenter.uiModel?.phoneNumber, "905331234567")
        XCTAssertEqual(self.otpView.presenter.uiModel?.otpTimeout, 90)
    }
    
    func test02VerifyOTPSuccess() async throws {
        // Setup service
        self.setResponse(for: "OTP/Verify", fileName: "otpVerifySuccess", statusCode: 200)
        self.setResponseHeaders(for: "OTP/Verify", fileName: "otpVerifySuccessHeaders")
        
        // Instantiate controller
//        self.setupView(view: self.otpView, environment: self.environment)
        
        // Wait page load
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check Member
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.otpView.presenter.otpVerify(otp: "597947")
            }
        }
        
        // Wait loading and services
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
    }
}
