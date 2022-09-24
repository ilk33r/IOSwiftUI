//
//  IOLogger.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation
import os
import IOSwiftUICommon

final public class IOLogger: IOSingleton {
    
    // MARK: - Defs
    
    public typealias InstanceType = IOLogger
    public static var _sharedInstance: IOLogger!
    
    // MARK: - DI
    
    @IOInject private var appState: IOAppStateImpl
    
    // MARK: - Privates
    
    private var logger: OSLog
    private var logLevel: IOLogLevels
    
    // MARK: - Initialization Methods
    
    public init() {
        self.logger = OSLog.default
        self.logLevel = IOLogLevels(rawValue: IOConfigurationImpl.shared.configForType(type: .loggingLogLevel)) ?? .error
    }
    
    // MARK: - Logging Methods
    
    fileprivate func logVerbose(_ logMessage: String) {
        guard self.logLevel == .verbose else {
            return
        }
        let targetName = self.appState.targetName
        os_log("%@: %{public}s", log: self.logger, type: .default, targetName, logMessage)
    }
    
    fileprivate func logInfo(_ logMessage: String) {
        guard self.logLevel == .verbose || self.logLevel == .info else {
            return
        }
        
        let targetName = self.appState.targetName
        os_log("%@: %{public}s", log: self.logger, type: .info, targetName, logMessage)
    }
    
    fileprivate func logDebug(_ logMessage: String) {
        guard self.logLevel == .verbose || self.logLevel == .info || self.logLevel == .debug else {
            return
        }
        
        let targetName = self.appState.targetName
        os_log("%@: %{public}s", log: self.logger, type: .debug, targetName, logMessage)
    }
    
    fileprivate func logWarning(_ logMessage: String) {
        guard self.logLevel == .verbose || self.logLevel == .info || self.logLevel == .debug || self.logLevel == .warning else {
            return
        }
        
        let targetName = self.appState.targetName
        os_log("%@ %{public}s", log: self.logger, type: .error, targetName, logMessage)
    }
    
    fileprivate func logError(_ logMessage: String) {
        guard self.logLevel == .verbose || self.logLevel == .info || self.logLevel == .debug || self.logLevel == .warning || self.logLevel == .error else {
            return
        }
        
        let targetName = self.appState.targetName
        os_log("%@ %{public}s", log: self.logger, type: .fault, targetName, logMessage)
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
            self.icon(for: level),
            message ?? ""
        )
        
        return formattedMessage
    }
    
    private func icon(for level: IOLogLevels) -> String {
        if level == .verbose {
            return "⚫️"
        }
        
        if level == .debug {
            return "🔵"
        }
        
        if level == .info {
            return "⚪️"
        }
        
        if level == .warning {
            return "🟡"
        }
        
        return "🔴"
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
