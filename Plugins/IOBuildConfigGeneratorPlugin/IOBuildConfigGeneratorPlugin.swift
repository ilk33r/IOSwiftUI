//
//  IOBuildConfigGeneratorPlugin.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.09.2022.
//

import Foundation
import PackagePlugin

@main
struct IOBuildConfigGeneratorPlugin: BuildToolPlugin {
    
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let environments = ProcessInfo.processInfo.environment
        print("**IOBuildConfigGeneratorPlugin: \(environments)")
        print("**IOBuildConfigGeneratorPlugin: \(target.directory)")
        print("**IOBuildConfigGeneratorPlugin: \(context.pluginWorkDirectory)")
        print("**IOBuildConfigGeneratorPlugin: \(context.package.directory)")
        
        let shellFile = context.package.directory.appending("/Plugins/IOBuildConfigGeneratorPlugin/CompileBuildConfigGenerator.sh")
        let outputPath = "\(context.pluginWorkDirectory)/"
        return [
            .buildCommand(
                displayName: "CompileBuildConfigGenerator",
                executable: shellFile,
                arguments: [context.pluginWorkDirectory, outputPath, target.directory, context.package.directory],
                outputFiles: [Path("\(outputPath)/IOBuildConfigGenerator")]
            )
        ]
    }
}
