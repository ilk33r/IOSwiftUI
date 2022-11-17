//
//  IOAlertPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public protocol IOAlertPresenter: IOObject {
    
    func show(handler: @escaping IOAlertHandler)
    func dismiss()
}
