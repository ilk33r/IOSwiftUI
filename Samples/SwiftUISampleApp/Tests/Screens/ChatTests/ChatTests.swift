//
//  ChatTests.swift
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
@testable import SwiftUISampleAppCommon
@testable import SwiftUISampleAppPresentation
@testable import SwiftUISampleAppScreensChat
@testable import SwiftUISampleAppScreensShared

final class ChatTests: BaseTestCase {
    
    // MARK: - Bundle
    
    override var bundleName: String { "SwiftUISampleApp_ChatTests" }
    
    // MARK: - Views
    
    private var chatView: ChatView!
    
    // MARK: - Tests
    
    override func setUp() async throws {
        try await super.setUp()
        
        let inbox = InboxModel()
        inbox.userName = "İlker"
        
        self.chatView = ChatView(
            entity: ChatEntity(
                toMemberId: 0,
                inbox: inbox,
                messages: [],
                pagination: PaginationModel(start: 0, count: 10, total: nil)
            )
        )
    }
    
    func test01LoadLastMessagesSuccess() async throws {
        // Setup service
        self.setResponse(for: "DirectMessage/GetMessages", fileName: "getMessagesSuccess", statusCode: 200)
        self.setResponseHeaders(for: "DirectMessage/GetMessages", fileName: "getMessagesSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.chatView, environment: self.environment)
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check message count
        XCTAssertEqual(self.chatView.presenter.chatMessages.count, 0)
        
        // Load previous messages
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.chatView.presenter.loadPreviousMessages()
            }
        }
        
        // Wait loading and services
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertEqual(self.chatView.presenter.chatMessages.count, 15)
    }
    
    func test02SendMessageSuccess() async throws {
        // Setup service
        self.setResponse(for: "DirectMessage/SendMessage", fileName: "sendMessageSuccess", statusCode: 200)
        self.setResponseHeaders(for: "DirectMessage/SendMessage", fileName: "sendMessageSuccessHeaders")
        
        // Instantiate controller
        self.setupView(view: self.chatView, environment: self.environment)
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Setup properties
        self.appState.set(object: Data(secureRandomizedData: 16), forType: .aesIV)
        self.appState.set(object: Data(secureRandomizedData: 32), forType: .aesKey)
        
        // Send message
        self.thread.runOnBackgroundThread(afterMilliSecond: self.presenterWaitTime) {
            Task {
                await self.chatView.presenter.sendMessage(message: "Hello")
            }
        }
        
        // Wait loading and services
        try await self.waitServiceCall()
        
        // Wait presenter
        await self.wait(milliseconds: self.presenterWaitTime)
        
        // Check first service
        XCTAssertNil(self.environment.alertData)
        XCTAssertFalse(self.environment.showLoading)
        XCTAssertEqual(self.chatView.presenter.chatMessages.count, 1)
    }
}
