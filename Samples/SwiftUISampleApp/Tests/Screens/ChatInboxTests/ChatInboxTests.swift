//
//  ChatInboxTests.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.05.2023.
//

import Foundation
import SwiftUI
import XCTest
@testable import IOSwiftUIInfrastructure
@testable import IOSwiftUIPresentation
@testable import SwiftUISampleAppCommonTests
@testable import SwiftUISampleAppPresentation
@testable import SwiftUISampleAppScreensChatInbox
@testable import SwiftUISampleAppScreensShared

final class ChatInboxTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_ChatInboxTests" }
    
    // MARK: - Views
    
    private var chatInboxView: ChatInboxView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.chatInboxView = ChatInboxView(
            entity: nil
        )
    }
    
    func test01ChatInboxSuccess() async throws {
        // Setup service
        self.setResponse(for: "DirectMessage/GetInboxes", fileName: "getInboxesSuccess", statusCode: 200)
        self.setResponseHeaders(for: "DirectMessage/GetInboxes", fileName: "getInboxesSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.chatInboxView, environment: self.environment)
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertEqual(self.chatInboxView.presenter.inboxes.count, 2)
    }
    
    func test02DeleteInboxSuccess() async throws {
        // Setup service
        self.setResponse(for: "DirectMessage/DeleteInbox?inboxID=6", fileName: "deleteInboxSuccess", statusCode: 200)
        self.setResponseHeaders(for: "DirectMessage/DeleteInbox?inboxID=6", fileName: "deleteInboxSuccessHeaders")
        self.setResponse(for: "DirectMessage/GetInboxes", fileName: "getInboxesSuccess", statusCode: 200)
        self.setResponseHeaders(for: "DirectMessage/GetInboxes", fileName: "getInboxesSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.chatInboxView, environment: self.environment)
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Delete inbox
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.chatInboxView.presenter.deleteInbox(index: 0)
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
        XCTAssertEqual(self.chatInboxView.presenter.inboxes.count, 2)
    }
    
    func test03GetMessagesSuccess() async throws {
        // Setup service
        self.setResponse(for: "DirectMessage/GetMessages", fileName: "getMessagesSuccess", statusCode: 200)
        self.setResponseHeaders(for: "DirectMessage/GetMessages", fileName: "getMessagesSuccessHeaders")
        self.setResponse(for: "DirectMessage/GetInboxes", fileName: "getInboxesSuccess", statusCode: 200)
        self.setResponseHeaders(for: "DirectMessage/GetInboxes", fileName: "getInboxesSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.chatInboxView, environment: self.environment)
        
        // Wait loading and services
        try await self.waitLoading()
        try await self.waitServiceCall()
        
        // Delete inbox
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.chatInboxView.presenter.getMessages(index: 0)
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
        XCTAssertTrue(self.chatInboxView.presenter.navigationState.wrappedValue.navigateToChat)
    }
}
