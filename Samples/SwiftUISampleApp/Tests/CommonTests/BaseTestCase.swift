//
//  BaseTestCase.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.05.2023.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUITestInfrastructure
import SwiftUI
import SwiftUISampleAppPresentation
import XCTest

open class BaseTestCase: IOTestCase {
    
    // MARK: - Defs
    
    public enum TestError: Error {
        case loading
    }
    
    // MARK: - Publics
    
    public let presenterWaitTime = 250
    
    // MARK: - Observers
    
    @ObservedObject public var environment = SampleAppEnvironment()
    
    // MARK: - Privates    
    
    private var loadingCancellable: AnyCancellable?
    private var loadingTimeout: IOCancellable?
    
    // MARK: - XCTest
    
    open override func setUp() async throws {
        TestAssembly.configureDI(container: IODIContainerImpl.shared)
        try await super.setUp()
    }
    
    // MARK: - Helper Methods
    
    public func setResponse(for path: String, fileName: String, statusCode: Int) {
        self.httpClient.setResponse(for: path, fileName: fileName, statusCode: statusCode, bundle: self.bundle)
    }
    
    public func setResponseHeaders(for path: String, fileName: String) {
        self.httpClient.setResponseHeaders(for: path, fileName: fileName, bundle: self.bundle)
    }
    
    // MARK: - Tests
    
    @discardableResult
    public func waitLoading() async throws -> Bool {
        self.loadingTimeout?.cancel()
        self.loadingCancellable?.cancel()
        self.loadingTimeout = nil
        self.loadingCancellable = nil
        
        return try await withUnsafeThrowingContinuation { [weak self] contination in
            guard let self else { return }
            
            self.loadingTimeout?.cancel()
            self.loadingTimeout = self.thread.runOnBackgroundThread(afterMilliSecond: self.testTimeout) {
                contination.resume(throwing: TestError.loading)
            }
            
            self.loadingCancellable = self.environment.$showLoading
                .sink(receiveValue: { newValue in
                    if newValue {
                        self.loadingTimeout?.cancel()
                        self.loadingTimeout = nil
                        self.loadingCancellable?.cancel()
                        self.loadingCancellable = nil
                        contination.resume(returning: true)
                    }
                })
        }
    }
}
