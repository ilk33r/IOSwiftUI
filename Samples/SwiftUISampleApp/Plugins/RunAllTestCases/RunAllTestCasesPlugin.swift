//
//  RunAllTestCasesPlugin.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.05.2023.
//

import Foundation
import PackagePlugin

@main
struct RunAllTestCasesPlugin: CommandPlugin {
    
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        print("Command arguments \(arguments.joined(separator: " "))")
        
        let tool = try context.tool(named: "xcodebuild")
        let toolUrl = URL(fileURLWithPath: tool.path.string)
        
        let workingDirectory = context.package.directory
        let cachePath = context.pluginWorkDirectory.appending(subpath: "SwiftLintCache")
        let lintArguments = processArguments(
            workingDirectory: workingDirectory,
            cachePath: cachePath.string
        )
        
        let process = Process()
        process.executableURL = toolUrl
        process.arguments = lintArguments
        print(toolUrl.path, process.arguments!.joined(separator: " "))
        
        // xcodebuild -project IOSwiftUISample.xcodeproj -scheme SplashTests -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 14,OS=16.4' test -testPlan SplashTests
        
        try process.run()
        process.waitUntilExit()
        
        if process.terminationReason == .exit && process.terminationStatus == 0 {
            print("Lint the source code in \(arguments.joined(separator: " "))")
        } else {
            let error = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("swiftlint invocation failed: \(error)")
        }
    }
    
    private func processArguments(workingDirectory: Path, cachePath: String) -> [String] {
        let lintConfig = workingDirectory.appending(subpath: ".swiftlint.yml")
        
        let lintArguments = [
            "lint",
            "--cache-path",
            cachePath,
            "--config",
            lintConfig.string,
            workingDirectory.appending(subpath: "Sources").string
        ]
        return lintArguments
    }
}
