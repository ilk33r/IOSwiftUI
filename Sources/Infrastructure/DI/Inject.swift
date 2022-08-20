//
//  Inject.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation

@propertyWrapper public struct Inject<Value: Singleton> {
    
    public var wrappedValue: Value

    public init() {
        // swiftlint:disable force_cast
        self.wrappedValue = Value.shared as! Value
        // swiftlint:enable force_cast
    }
}
