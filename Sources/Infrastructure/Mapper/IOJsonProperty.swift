//
//  IOJsonProperty.swift
//  
//
//  Created by Adnan ilker Ozcan on 24.09.2022.
//

import Foundation

@propertyWrapper public class IOJsonProperty<TType>: IOJsonPropertyProtocol {
    
    // MARK: - Publics
    
    public var key: String
    
    // MARK: - Privates
    
    private var _alternateKey: String?
    private var _transformer: IOModelTransformer?
    private var _wrappedValue: TType?
    
    // MARK: - Wrapper

    public var wrappedValue: TType? {
        get {
            return self._wrappedValue
        }
        set {
            self._wrappedValue = newValue
        }
    }
    
    public init(key: String, alternateKey: String? = nil, defaultValue: TType? = nil, transformer: IOModelTransformer? = nil) {
        self.key = key
        self._alternateKey = alternateKey
        self._transformer = transformer
        self._wrappedValue = defaultValue
    }
}

extension IOJsonProperty: IOModelEncodableProperty where TType: Encodable {
    
    internal func encodeValue(from container: inout EncodeContainer, propertyName: String) throws {
        let codingKey = IOModelCodingKey(key)
        
        if let transformer = self._transformer {
            let transformedValue = transformer.toJSONString(data: self._wrappedValue)
            try container.encodeIfPresent(transformedValue, forKey: codingKey)
            return
        }
        
        try container.encodeIfPresent(self._wrappedValue, forKey: codingKey)
    }
}

extension IOJsonProperty: IOModelDecodableProperty where TType: Decodable {
    
    internal func decodeValue(from container: DecodeContainer, propertyName: String) throws {
        let codingKey = IOModelCodingKey(key)

        if let transformer = self._transformer, let value = try? container.decodeIfPresent(String.self, forKey: codingKey) {
            self._wrappedValue = transformer.fromJSONString(string: value)
        } else if let value = try? container.decodeIfPresent(TType.self, forKey: codingKey) {
            self._wrappedValue = value
        } else {
            guard let altKey = self._alternateKey else { return }
            let altCodingKey = IOModelCodingKey(altKey)
            if let value = try? container.decodeIfPresent(TType.self, forKey: altCodingKey) {
                self._wrappedValue = value
            }
        }
    }
}
