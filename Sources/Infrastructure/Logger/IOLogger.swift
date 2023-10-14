//
//  IOLogger.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import IOSwiftUICommon
import os

public struct IOLogger: IOSingleton {
    
    // MARK: - Defs
    
    public typealias InstanceType = IOLogger
    public static var _sharedInstance: IOLogger!
    
    // MARK: - DI
    
    @IOInject private var appState: IOAppState
    @IOInject private var configuration: IOConfiguration
    
    // MARK: - Privates
    
    private var logger: os.Logger!
    private var logLevel: IOLogLevels!
    
    // MARK: - Initialization Methods
    
    public init() {
        self.logger = os.Logger(subsystem: "com.ioswiftui.infrastructure.logger", category: appState.targetName)
        self.logLevel = IOLogLevels(rawValue: self.configuration.configForType(type: .loggingLogLevel)) ?? .error
    }
    
    // MARK: - Logging Methods
    
    private func logVerbose(_ logMessage: String) {
        guard logLevel == .verbose else {
            return
        }
        logger.trace("\(logMessage)")
    }
    
    private func logInfo(_ logMessage: String) {
        logger.info("\(logMessage)")
    }
    
    private func logDebug(_ logMessage: String) {
        guard logLevel == .verbose || logLevel == .info || logLevel == .debug else {
            return
        }
        
        logger.debug("\(logMessage)")
    }
    
    private func logWarning(_ logMessage: String) {
        guard logLevel == .verbose || logLevel == .info || logLevel == .debug || logLevel == .warning else {
            return
        }
        
        logger.warning("\(logMessage)")
    }
    
    private func logError(_ logMessage: String) {
        guard logLevel == .verbose || logLevel == .info || logLevel == .debug || logLevel == .warning || logLevel == .error else {
            return
        }
        
        logger.error("\(logMessage)")
    }
    
    // MARK: - Helper Methods
    
    private func formatLogMessage(
        level: IOLogLevels,
        message: String?,
        file: StaticString,
        function: StaticString,
        line: UInt,
        column: UInt
    ) -> String {
        let logLevelString = level.rawValue.uppercased()
        let formattedMessage = String(
            format: "\n%@ %@ %d:%d\n%@: %@\n%@\n",
            String(describing: file),
            String(describing: function),
            line,
            column,
            logLevelString,
            icon(for: level),
            message ?? ""
        )
        
        return formattedMessage
    }
    
    private func icon(for level: IOLogLevels) -> String {
        if level == .verbose {
            return "\u{000026AB}"
        }
        
        if level == .debug {
            return "\u{0001F535}"
        }
        
        if level == .info {
            return "\u{000026AA}"
        }
        
        if level == .warning {
            return "\u{0001F7E1}"
        }
        
        return "\u{0001F534}"
    }
}

public extension IOLogger {
    
    static func verbose(
        _ message: String?,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        let formattedMessage = IOLogger.shared.formatLogMessage(
            level: .verbose,
            message: message,
            file: file,
            function: function,
            line: line,
            column: column
        )
        
        IOLogger.shared.logVerbose(formattedMessage)
    }
    
    static func debug(
        _ message: String?,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        let formattedMessage = IOLogger.shared.formatLogMessage(
            level: .debug,
            message: message,
            file: file,
            function: function,
            line: line,
            column: column
        )
        
        IOLogger.shared.logDebug(formattedMessage)
    }
    
    static func info(
        _ message: String?,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        let formattedMessage = IOLogger.shared.formatLogMessage(
            level: .info,
            message: message,
            file: file,
            function: function,
            line: line,
            column: column
        )
        
        IOLogger.shared.logInfo(formattedMessage)
    }
    
    static func warning(
        _ message: String?,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        let formattedMessage = IOLogger.shared.formatLogMessage(
            level: .warning,
            message: message,
            file: file,
            function: function,
            line: line,
            column: column
        )
        
        IOLogger.shared.logWarning(formattedMessage)
    }
    
    static func error(
        _ message: String?,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        let formattedMessage = IOLogger.shared.formatLogMessage(
            level: .error,
            message: message,
            file: file,
            function: function,
            line: line,
            column: column
        )
        
        IOLogger.shared.logError(formattedMessage)
    }
}
