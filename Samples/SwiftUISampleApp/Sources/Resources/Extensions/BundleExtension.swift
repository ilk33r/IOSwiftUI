//
//  BundleExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation

private class ResourcesBundleFinder {}

public extension Bundle {
    
    static var resources: Bundle = {
        let bundleName = "SwiftUISampleApp_SwiftUISampleAppResources"
        
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: ResourcesBundleFinder.self).resourceURL,
            /* For command-line tools. */
            Bundle.main.bundleURL,
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
            Bundle(for: ResourcesBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("Unable to find bundle named \(bundleName)")
    }()
}
