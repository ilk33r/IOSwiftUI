//
//  IORouterGeneratorPlugin.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import PackagePlugin

@main
struct IORouterGeneratorPlugin: BuildToolPlugin {
    
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let environments = ProcessInfo.processInfo.environment
        print("**IORouterGeneratorPlugin: \(environments)")
        print("**IORouterGeneratorPlugin: \(target.directory)")
        print("**IORouterGeneratorPlugin: \(context.pluginWorkDirectory)")
        print("**IORouterGeneratorPlugin: \(context.package.directory)")
        
        let dependencies = context.package.dependencies.filter { $0.package.id == "IOSwiftUI".lowercased() }
        let ioSwiftUIPackage = dependencies.first?.package
        guard let pluginDirectory = ioSwiftUIPackage?.directory else {
            fatalError("IOSwiftUI dependency not found in \(target.name) target")
        }
        
        var arguments = [
            target.directory.string,
            context.pluginWorkDirectory.string,
            context.package.directory.string,
            pluginDirectory.string
        ]
        context.package.targets.forEach { it in
            if it.name.contains("Screens") && !it.name.contains("Shared") {
                print("**IORouterGeneratorPlugin Adding argument: \(it.name) \(it.directory)")
                arguments.append(it.name)
                arguments.append(it.directory.string)
            }
        }
        
        let checkCmdShellFile = pluginDirectory.appending("/Plugins/IORouterGeneratorPlugin/CheckScreenNames.sh")
        let generateCmdShellFile = pluginDirectory.appending("/Plugins/IORouterGeneratorPlugin/GenerateAppRouter.sh")
        let generatedFile = context.pluginWorkDirectory.appending(subpath: "Generated/AppRouter.swift")
        
        return [
            .prebuildCommand(
                displayName: "CheckScreenNames",
                executable: checkCmdShellFile,
                arguments: arguments,
                outputFilesDirectory: context.pluginWorkDirectory.appending("Generated")
            ),
            .buildCommand(
                displayName: "GenerateAppRouter",
                executable: generateCmdShellFile,
                arguments: arguments,
                inputFiles: [context.pluginWorkDirectory],
                outputFiles: [generatedFile]
            )
        ]
    }
}
