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
        
        let dependencies = context.package.dependencies.filter { $0.package.id == "IOSwiftUI".lowercased() }
        let ioSwiftUIPackage = dependencies.first?.package
        guard let pluginDirectory = ioSwiftUIPackage?.directory else {
            fatalError("IOSwiftUI dependency not found in \(target.name) target")
        }
        
        let checkCmdShellFile = pluginDirectory.appending("/Plugins/IOBuildConfigGeneratorPlugin/CheckConfigurationFileHash.sh")
        let compileCmdShellFile = pluginDirectory.appending("/Plugins/IOBuildConfigGeneratorPlugin/CompileBuildConfigGenerator.sh")
        let generatedPath = context.pluginWorkDirectory.appending(subpath: "Generated/IOBuildConfig.swift")
        
        return [
            .prebuildCommand(
                displayName: "CheckConfigurationFileHash",
                executable: checkCmdShellFile,
                arguments: [target.directory, context.pluginWorkDirectory, context.package.directory, pluginDirectory],
                outputFilesDirectory: context.pluginWorkDirectory.appending("Generated")
            ),
            .buildCommand(
                displayName: "CompileBuildConfigGenerator",
                executable: compileCmdShellFile,
                arguments: [target.directory, context.pluginWorkDirectory, context.package.directory, pluginDirectory],
                inputFiles: [context.pluginWorkDirectory],
                outputFiles: [generatedPath]
            )
        ]
    }
}
