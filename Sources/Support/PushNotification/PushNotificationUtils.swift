//
//  PushNotificationUtils.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.04.2023.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import UIKit

public struct PushNotificationUtils {
    
    // MARK: - Defs
    
    public typealias Handler = (_ granted: Bool) -> Void
    
    // MARK: - DI
    
    @IOInject private static var configuration: IOConfiguration
    @IOInject private static var localization: IOLocalization
    @IOInject private static var mapper: IOMapper
    
    // MARK: - Constants
    
    private static let categoriesConfigType = IOConfigurationType(rawValue: "PUSH_NOTIFICATION_CATEGORIES")
    
    // MARK: - Privates
    
    private static var isRegisteringNotificationSettings = false
    
    // MARK: - Notification Utils Methods
    
    public static func configurePushNotifications(_ handler: Handler?) {
        // Check is registering
        if self.isRegisteringNotificationSettings {
            // Do nothing
            return
        }
        
        // Set notification registering
        self.isRegisteringNotificationSettings = true
        
        // Obtain application
        let application = UIApplication.shared
        
        // Register notification settings
        self.registerNotificationSettingsAndCategories(application, handler: handler)
    }
    
    public static func mapPayload<TModel: ApnsModel>(modelClass: TModel.Type, payload: [AnyHashable: Any]) -> TModel? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: .init()) {
            
            do {
                let responseModel = try self.mapper.mapJson(model: TModel.self, data: jsonData)
                return responseModel
            } catch let err {
                IOLogger.error(err.localizedDescription)
            }
        }
        
        return nil
    }
    
    // MARK: - Privates
    
    private static func registerNotificationSettingsAndCategories(_ application: UIApplication, handler: Handler?) {
        // Create notification categories
        var userNotificationCategories: [UNNotificationCategory]?
        
        // Obtain push notification actions from configuration
        let categoriesJsonString = self.configuration.configForType(type: self.categoriesConfigType)
        if !categoriesJsonString.isEmpty {
            // Create notification categories
            if let categories = categoriesJsonString.toJsonDictionary() {
                userNotificationCategories = self.notificationCategories(categories: categories)
            }
        }

        let notificationCenter = UNUserNotificationCenter.current()
        let options = UNAuthorizationOptions(arrayLiteral: [.badge, .sound, .alert])
        notificationCenter.requestAuthorization(options: options) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                    handler?(true)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                handler?(false)
            }
        }
        
        if let categories = userNotificationCategories {
            // Create notification sets
            let userNotificationSets = Set(categories)
            notificationCenter.setNotificationCategories(userNotificationSets)
        }
    }
    
    // MARK: - Notification Helper Methods
    
    private static func notificationCategories(categories: [AnyHashable: Any]) -> [UNNotificationCategory] {
        // Create notification categories
        var userNotificationCategories = [UNNotificationCategory]()
        
        // Loop throught notification categories
        for (key, value) in categories {
            // Obtain notification actions
            if let identifiers = value as? [String] {
                let userNotificationActions = self.notificationActionsForIdentifiers(identifiers: identifiers)
                
                // Create notification category
                let notificationCategory = UNNotificationCategory(
                    identifier: (key as? String)!,
                    actions: userNotificationActions,
                    intentIdentifiers: [],
                    options: .init(rawValue: 0)
                )
                
                // Append category to array
                userNotificationCategories.append(notificationCategory)
            }
        }
        
        // Return categories
        return userNotificationCategories
    }
    
    private static func notificationActionsForIdentifiers(identifiers: [String]) -> [UNNotificationAction] {
        // Create notification actions array
        var userNotificationActions = [UNNotificationAction]()
        
        // Loop throught action identifiers
        for actionIdentifier in identifiers {
            // Create notification action
            let actionTitle = self.localization.string(actionIdentifier)
            let notificationAction = UNNotificationAction(identifier: actionIdentifier, title: actionTitle, options: .foreground)
            
            // Append action to array
            userNotificationActions.append(notificationAction)
        }
        
        // Return actions
        return userNotificationActions
    }
}
