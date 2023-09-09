//
//  IOPresenterError.swift
//
//
//  Created by Adnan ilker Ozcan on 2.09.2023.
//

import Foundation

public enum IOPresenterError: Error {
    
    case prefetch(title: String?, message: String, buttonTitle: String)
}
