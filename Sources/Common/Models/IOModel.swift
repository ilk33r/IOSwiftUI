//
//  IOModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation

open class IOModel: Codable {
    
    // MARK: - Decoding and Encoding
    
    public required init(from decoder: Decoder) throws {
        // Get the container keyed by the SerializedCodingKeys defined by the propertyWrapper @Serialized
        let container = try decoder.container(keyedBy: IOModelCodingKey.self)
        
        // Mirror for current model
        var mirror: Mirror? = Mirror(reflecting: self)

        // Go through all mirrors (till top most superclass)
        repeat {
            // If mirror is nil (no superclassMirror was nil), break
            guard let children = mirror?.children else { break }
            
            // Try to decode each child
            for child in children {
                guard let decodableKey = child.value as? IOModelDecodableProperty else { continue }
                
                // Get the propertyName of the property. By syntax, the property name is
                // in the form: "_name". Dropping the "_" -> "name"
                let propertyName = String((child.label ?? "").dropFirst())
                
                try decodableKey.decodeValue(from: container, propertyName: propertyName)
            }
            mirror = mirror?.superclassMirror
        } while mirror != nil
    }
    
    public init() {
    }
    
    public func encode(to encoder: Encoder) throws {
        // Get the container keyed by the SerializedCodingKeys defined by the propertyWrapper @Serialized
        var container = encoder.container(keyedBy: IOModelCodingKey.self)
        
        // Mirror for current model
        var mirror: Mirror? = Mirror(reflecting: self)

        // Go through all mirrors (till top most superclass)
        repeat {
            // If mirror is nil (no superclassMirror was nil), break
            guard let children = mirror?.children else { break }
            
            // Try to encode each child
            for child in children {
                guard let encodableKey = child.value as? IOModelEncodableProperty else { continue }
                
                // Get the propertyName of the property. By syntax, the property name is
                // in the form: "_name". Dropping the "_" -> "name"
                let propertyName = String((child.label ?? "").dropFirst())
                
                // propertyName here is not neceserly used in the `encodeValue` method
                try encodableKey.encodeValue(from: &container, propertyName: propertyName)
            }
            mirror = mirror?.superclassMirror
        } while mirror != nil
    }
}
