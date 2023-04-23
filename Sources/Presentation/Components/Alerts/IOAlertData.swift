//
//  IOAlertData.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public typealias IOAlertHandler = () -> IOAlertData
public typealias IOAlertResultHandler = (_ index: Int) -> Void

public struct IOAlertData: Equatable, Identifiable {
    
    public let title: String?
    public let message: String
    public let buttons: [String]
    public let handler: IOAlertResultHandler?
    
    public let id = UUID()
    
    public init(title: String?, message: String, buttons: [String], handler: IOAlertResultHandler?) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.handler = handler
    }
    
    public init(title: IOLocalizationType, message: String, buttons: [String], handler: IOAlertResultHandler?) {
        self.title = title.localized
        self.message = message
        self.buttons = buttons
        self.handler = handler
    }
    
    public init(title: IOLocalizationType, message: IOLocalizationType, buttons: [String], handler: IOAlertResultHandler?) {
        self.title = title.localized
        self.message = message.localized
        self.buttons = buttons
        self.handler = handler
    }
    
    public init(title: IOLocalizationType, message: IOLocalizationType, buttons: [IOLocalizationType], handler: IOAlertResultHandler?) {
        self.title = title.localized
        self.message = message.localized
        self.buttons = buttons.map({ $0.localized })
        self.handler = handler
    }
    
    public init(title: IOLocalizationType, message: String, buttons: [IOLocalizationType], handler: IOAlertResultHandler?) {
        self.title = title.localized
        self.message = message
        self.buttons = buttons.map({ $0.localized })
        self.handler = handler
    }
    
    public init(title: String?, message: IOLocalizationType, buttons: [IOLocalizationType], handler: IOAlertResultHandler?) {
        self.title = title
        self.message = message.localized
        self.buttons = buttons.map({ $0.localized })
        self.handler = handler
    }
    
    public init(title: String?, message: String, buttons: [IOLocalizationType], handler: IOAlertResultHandler?) {
        self.title = title
        self.message = message
        self.buttons = buttons.map({ $0.localized })
        self.handler = handler
    }
    
    public static func == (lhs: IOAlertData, rhs: IOAlertData) -> Bool {
        false
    }
}
