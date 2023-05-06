//
//  BaseTestCase.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.05.2023.
//

import Combine
import Foundation
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
    
    // MARK: - Observers
    
    @ObservedObject public var environment = SampleAppEnvironment()
    
    // MARK: - Privates    
    
    private var loadingCancellable: AnyCancellable?
    
    // MARK: - XCTest
    
    open override func setUp() async throws {
        TestAssembly.configureDI(container: IODIContainerImpl.shared)
        try await super.setUp()
    }
    
    // MARK: - Helper Methods
    
    public func setResponse(for path: String, fileName: String) {
        self.httpClient.setResponse(for: path, fileName: fileName, bundle: self.bundle)
    }
    
    public func setResponseHeaders(for path: String, fileName: String) {
        self.httpClient.setResponseHeaders(for: path, fileName: fileName, bundle: self.bundle)
    }
    
    public func setResponseStatusCode(for path: String, statusCode: Int) {
        self.httpClient.setResponseStatusCode(for: path, statusCode: statusCode)
    }
    
    // MARK: - Tests
    
    @discardableResult
    public func waitLoading() async throws -> Bool {
        return try await withUnsafeThrowingContinuation { [weak self] contination in
            guard let self else { return }
            let timeout = self.thread.runOnBackgroundThread(afterMilliSecond: self.testTimeout) {
                contination.resume(throwing: TestError.loading)
            }
            
            self.loadingCancellable = self.environment.$showLoading
                .sink(receiveValue: { newValue in
                    if newValue {
                        timeout.cancel()
                        self.loadingCancellable?.cancel()
                        self.loadingCancellable = nil
                        contination.resume(returning: true)
                    }
                })
        }
    }
}
