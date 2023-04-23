//
//  IOToastData.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.01.2023.
//

import Foundation
import IOSwiftUIInfrastructure

public struct IOToastData: Equatable {
    
    // MARK: - Defs
    
    public typealias DataHandler = () -> IOToastData
    
    public enum ToastType {
        case success
        case error
        case warning
        case info
    }
    
    // MARK: - Properties
    
    public let duration: Int
    public let message: String
    public let title: String?
    public let type: ToastType
    
    // MARK: - Initialization Methods
    
    public init(_ type: ToastType, title: String?, message: String, duration: Int = 3500) {
        self.type = type
        self.title = title
        self.message = message
        self.duration = duration
    }
    
    public init(_ type: ToastType, title: IOLocalizationType, message: String, duration: Int = 3500) {
        self.type = type
        self.title = title.localized
        self.message = message
        self.duration = duration
    }
    
    public init(_ type: ToastType, title: IOLocalizationType, message: IOLocalizationType, duration: Int = 3500) {
        self.type = type
        self.title = title.localized
        self.message = message.localized
        self.duration = duration
    }
    
    public init(_ type: ToastType, title: String?, message: IOLocalizationType, duration: Int = 3500) {
        self.type = type
        self.title = title
        self.message = message.localized
        self.duration = duration
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: IOToastData, rhs: IOToastData) -> Bool {
        false
    }
}
