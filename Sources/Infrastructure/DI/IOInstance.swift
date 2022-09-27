//
//  IOInstance.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import Foundation

@propertyWrapper public struct IOInstance<Value: IOObject> {
    
    public var wrappedValue: Value

    public init() {
        // swiftlint:disable explicit_init
        self.wrappedValue = Value.init()
        // swiftlint:enable explicit_init
    }
}
