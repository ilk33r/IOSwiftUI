//
//  IOSwiftLintPlugin.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.04.2023.
//

import Foundation
import PackagePlugin

@main
struct IOSwiftLintPlugin: CommandPlugin {
    
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        print("Command arguments \(arguments.joined(separator: " "))")
        
        let tool = try context.tool(named: "swiftlint")
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
