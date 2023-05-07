//
//  IOTestCase.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.05.2023.
//

import Combine
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import UIKit
import XCTest

open class IOTestCase: XCTestCase {
    
    // MARK: - Defs
    
    public enum TestError: Error {
        case service
    }
    
    // MARK: - DI
    
    @IOInject public var appState: IOAppState
    @IOInject public var localStorage: IOLocalStorage
    @IOInject public var thread: IOThread
    @IOInject public var _httpClient: IOHTTPClient
    
    // MARK: - Properties
    
    public let testTimeout = 3000
    
    open var bundleName: String { "" }
    open var window: UIWindow!
    
    public var httpRequestCancellable: AnyCancellable?
    
    public var bundle: Bundle {
        let mainBundle = Bundle(for: Self.self).resourceURL
        let bundlePath = mainBundle?.appendingPathComponent(self.bundleName + ".bundle")
        if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
            return bundle
        }
        
        fatalError("Unable to find bundle named \(self.bundleName)")
    }
    
    public var httpClient: IOHTTPClientTestImpl {
        self._httpClient as! IOHTTPClientTestImpl
    }
    
    // MARK: - Privates
    
    private var httpRequestTimeout: IOCancellable?
    
    // MARK: - Test Methods
    
    open override func setUp() async throws {
    }

    open override func tearDownWithError() throws {
    }
    
    open func setupView<TView: View>(view: TView, environment: any IOAppEnvironment) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let environmentView = view.environmentObject(environment)
        let hostingController = UIHostingController(rootView: AnyView(environmentView))
        self.window.rootViewController = hostingController
        self.window.makeKeyAndVisible()
    }
    
    @discardableResult
    public func waitServiceCall(count: Int = 1) async throws -> Bool {
        self.httpRequestTimeout?.cancel()
        self.httpRequestTimeout = nil
        self.httpRequestCancellable?.cancel()
        self.httpRequestCancellable = nil
        
        return try await withUnsafeThrowingContinuation { [weak self] contination in
            guard let self else { return }
            
            self.httpRequestTimeout?.cancel()
            self.httpRequestTimeout = self.thread.runOnBackgroundThread(afterMilliSecond: self.testTimeout * count) {
                contination.resume(throwing: TestError.service)
            }
            
            self.httpRequestCancellable = self.httpClient.httpRequestStatus
                .dropFirst(count - 1)
                .sink(receiveValue: { newValue in
                    if newValue ?? false {
                        self.httpRequestTimeout?.cancel()
                        self.httpRequestTimeout = nil
                        self.httpRequestCancellable?.cancel()
                        self.httpRequestCancellable = nil
                        contination.resume(returning: true)
                    }
                })
        }
    }
    
    @discardableResult
    public func wait(milliseconds: Int) async -> Bool {
        return await withUnsafeContinuation { [weak self] contination in
            guard let self else { return }
            
            self.thread.runOnBackgroundThread(afterMilliSecond: milliseconds) {
                contination.resume(returning: true)
            }
        }
    }
}
