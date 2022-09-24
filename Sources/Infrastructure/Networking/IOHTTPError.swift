//
//  IOHTTPError.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

public struct IOHTTPError: Error {
    
    // MARK: - Types
    
    // swiftlint:disable nesting
    public struct ErrorType: RawRepresentable, Equatable {
        
        public typealias RawValue = Int

        public static let unspecified = ErrorType(rawValue: 0)
        public static let timeout = ErrorType(rawValue: 1)
        public static let notConnectedToInternet = ErrorType(rawValue: 2)
        public static let cancelled = ErrorType(rawValue: 3)
        public static let notConnectToHost = ErrorType(rawValue: 4)
        public static let authenticationRequired = ErrorType(rawValue: 5)
        public static let notDecodeResponse = ErrorType(rawValue: 6)
        public static let secureConnectionFailed = ErrorType(rawValue: 7)
        public static let tooManyRedirects = ErrorType(rawValue: 8)
        public static let notFound = ErrorType(rawValue: 9)
        public static let decodeError = ErrorType(rawValue: 10)
        
        public var rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    // swiftlint:enable nesting
    
    // MARK: - Publics
    
    public let code: Int
    public let errorType: ErrorType
    public var errorMessage: String?
    public var userInfo: [String: Any]?
    
    // MARK: - Initialization Methods
    
    internal init(error: NSError) {
        self.code = error.code
        
        if error.code == NSURLErrorTimedOut {
            self.errorType = .timeout
        } else if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
            self.errorType = .notConnectedToInternet
        } else if error.code == NSURLErrorCancelled {
            self.errorType = .cancelled
        } else if error.code == NSURLErrorBadURL
            || error.code == NSURLErrorUnsupportedURL
            || error.code == NSURLErrorCannotFindHost
            || error.code == NSURLErrorCannotConnectToHost
            || error.code == NSURLErrorDNSLookupFailed
            || error.code == NSURLErrorCannotLoadFromNetwork {
            self.errorType = .notConnectToHost
        } else if error.code == NSURLErrorUserCancelledAuthentication
            || error.code == NSURLErrorUserAuthenticationRequired
            || error.code == NSURLErrorClientCertificateRequired {
            self.errorType = .authenticationRequired
        } else if error.code == NSURLErrorBadServerResponse
            || error.code == NSURLErrorZeroByteResource
            || error.code == NSURLErrorCannotDecodeRawData
            || error.code == NSURLErrorCannotDecodeContentData
            || error.code == NSURLErrorCannotParseResponse
            || error.code == NSURLErrorDataLengthExceedsMaximum {
            self.errorType = .notDecodeResponse
        } else if error.code == NSURLErrorAppTransportSecurityRequiresSecureConnection
            || error.code == NSURLErrorSecureConnectionFailed
            || error.code == NSURLErrorServerCertificateHasBadDate
            || error.code == NSURLErrorServerCertificateUntrusted
            || error.code == NSURLErrorServerCertificateHasUnknownRoot
            || error.code == NSURLErrorServerCertificateNotYetValid
            || error.code == NSURLErrorClientCertificateRejected
            || error.code == NSURLErrorClientCertificateRejected {
            self.errorType = .secureConnectionFailed
        } else if error.code == NSURLErrorHTTPTooManyRedirects
            || error.code == NSURLErrorRedirectToNonExistentLocation {
            self.errorType = .tooManyRedirects
        } else if error.code == NSURLErrorResourceUnavailable
            || error.code == NSURLErrorFileDoesNotExist
            || error.code == NSURLErrorFileIsDirectory
            || error.code == NSURLErrorNoPermissionsToReadFile {
            self.errorType = .notFound
        } else {
            self.errorType = .unspecified
        }
    }
    
    public init(code: Int, message: String? = nil, userInfo: [String: Any]? = nil, errorType: ErrorType = .unspecified) {
        self.code = code
        self.errorType = .unspecified
        self.errorMessage = message
        self.userInfo = userInfo
    }
}
