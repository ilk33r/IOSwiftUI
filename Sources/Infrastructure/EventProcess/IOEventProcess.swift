//
//  IOEventProcess.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.02.2023.
//

import Combine
import Foundation
import IOSwiftUICommon

public protocol IOEventProcess {
    
    // MARK: - Getters
    
    func bool(forType type: IOPublisherType) -> AnyPublisher<Bool?, Never>
    func double(forType type: IOPublisherType) -> AnyPublisher<Double?, Never>
    func int(forType type: IOPublisherType) -> AnyPublisher<Int?, Never>
    func string(forType type: IOPublisherType) -> AnyPublisher<String?, Never>
    func object(forType type: IOPublisherType) -> AnyPublisher<Any?, Never>
    
    // MARK: - Setters
    
    func set(bool value: Bool, forType type: IOPublisherType)
    func set(double value: Double, forType type: IOPublisherType)
    func set(int value: Int, forType type: IOPublisherType)
    func set(string value: String, forType type: IOPublisherType)
    func set(object value: Any?, forType type: IOPublisherType)
    
    // MARK: - Removers
    
    func remove(type: IOPublisherType)
    func removeAllPublishers()
}
