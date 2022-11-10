//
//  IOSwiftUISampleAppDelegate.swift
//  IOSwiftUISample
//
//  Created by Adnan ilker Ozcan on 10.11.2022.
//

import Foundation
import UIKit

final class IOSwiftUISampleAppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
