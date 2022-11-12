//
//  IOAlertPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.11.2022.
//

import Foundation

public protocol IOAlertPresenter {
    
    func show(handler: @escaping IOAlertHandler)
    func dismiss()
}
