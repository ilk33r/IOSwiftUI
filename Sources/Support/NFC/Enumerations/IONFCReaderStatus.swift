//
//  IONFCReaderStatus.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation

public enum IONFCReaderStatus: Int {
    
    case started = 0
    case reading = 1
    case error = 2
    case finished = 3
}
