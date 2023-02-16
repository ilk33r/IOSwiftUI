//
//  IOEventProcessImpl.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.02.2023.
//

import Combine
import Foundation
import IOSwiftUICommon

final public class IOEventProcessImpl: IOEventProcess, IOSingleton {
    
    public typealias InstanceType = IOEventProcessImpl
    public static var _sharedInstance: IOEventProcessImpl!
    
    // MARK: - Privates
    
    private var boolPublishers: [IOPublisherType: PassthroughSubject<Bool?, Never>]
    private var doublePublishers: [IOPublisherType: PassthroughSubject<Double?, Never>]
    private var intPublishers: [IOPublisherType: PassthroughSubject<Int?, Never>]
    private var stringPublishers: [IOPublisherType: PassthroughSubject<String?, Never>]
    private var objectPublishers: [IOPublisherType: PassthroughSubject<Any?, Never>]
    
    // MARK: - Initialization Methods
    
    public init() {
        self.boolPublishers = [:]
        self.doublePublishers = [:]
        self.intPublishers = [:]
        self.stringPublishers = [:]
        self.objectPublishers = [:]
    }
    
    // MARK: - Getters
    
    public func bool(forType type: IOPublisherType) -> AnyPublisher<Bool?, Never> {
        if let publisher = self.boolPublishers[type] {
            return publisher.eraseToAnyPublisher()
        }
        
        let subject = PassthroughSubject<Bool?, Never>()
        self.boolPublishers[type] = subject
        return subject.eraseToAnyPublisher()
    }
    
    public func double(forType type: IOPublisherType) -> AnyPublisher<Double?, Never> {
        if let publisher = self.doublePublishers[type] {
            return publisher.eraseToAnyPublisher()
        }
        
        let subject = PassthroughSubject<Double?, Never>()
        self.doublePublishers[type] = subject
        return subject.eraseToAnyPublisher()
    }
    
    public func int(forType type: IOPublisherType) -> AnyPublisher<Int?, Never> {
        if let publisher = self.intPublishers[type] {
            return publisher.eraseToAnyPublisher()
        }
        
        let subject = PassthroughSubject<Int?, Never>()
        self.intPublishers[type] = subject
        return subject.eraseToAnyPublisher()
    }
    
    public func string(forType type: IOPublisherType) -> AnyPublisher<String?, Never> {
        if let publisher = self.stringPublishers[type] {
            return publisher.eraseToAnyPublisher()
        }
        
        let subject = PassthroughSubject<String?, Never>()
        self.stringPublishers[type] = subject
        return subject.eraseToAnyPublisher()
    }
    
    public func object(forType type: IOPublisherType) -> AnyPublisher<Any?, Never> {
        if let publisher = self.objectPublishers[type] {
            return publisher.eraseToAnyPublisher()
        }
        
        let subject = PassthroughSubject<Any?, Never>()
        self.objectPublishers[type] = subject
        return subject.eraseToAnyPublisher()
    }
    
    // MARK: - Setters
    
    public func set(bool value: Bool, forType type: IOPublisherType) {
        if let publisher = self.boolPublishers[type] {
            publisher.send(value)
        }
    }
    
    public func set(double value: Double, forType type: IOPublisherType) {
        if let publisher = self.doublePublishers[type] {
            publisher.send(value)
        }
    }
    
    public func set(int value: Int, forType type: IOPublisherType) {
        if let publisher = self.intPublishers[type] {
            publisher.send(value)
        }
    }
    
    public func set(string value: String, forType type: IOPublisherType) {
        if let publisher = self.stringPublishers[type] {
            publisher.send(value)
        }
    }
    
    public func set(object value: Any?, forType type: IOPublisherType) {
        if let publisher = self.objectPublishers[type] {
            publisher.send(value)
        }
    }
    
    // MARK: - Removers
    
    public func remove(type: IOPublisherType) {
        if let publisher = self.boolPublishers[type] {
            publisher.send(completion: .finished)
            self.boolPublishers.removeValue(forKey: type)
        }
        
        if let publisher = self.doublePublishers[type] {
            publisher.send(completion: .finished)
            self.doublePublishers.removeValue(forKey: type)
        }
        
        if let publisher = self.intPublishers[type] {
            publisher.send(completion: .finished)
            self.intPublishers.removeValue(forKey: type)
        }
        
        if let publisher = self.stringPublishers[type] {
            publisher.send(completion: .finished)
            self.stringPublishers.removeValue(forKey: type)
        }
        
        if let publisher = self.objectPublishers[type] {
            publisher.send(completion: .finished)
            self.objectPublishers.removeValue(forKey: type)
        }
    }
    
    public func removeAllPublishers() {
        self.boolPublishers.forEach { _, value in
            value.send(completion: .finished)
        }
        self.boolPublishers = [:]
        
        self.doublePublishers.forEach { _, value in
            value.send(completion: .finished)
        }
        self.doublePublishers = [:]
        
        self.intPublishers.forEach { _, value in
            value.send(completion: .finished)
        }
        self.intPublishers = [:]
        
        self.stringPublishers.forEach { _, value in
            value.send(completion: .finished)
        }
        self.stringPublishers = [:]
        
        self.objectPublishers.forEach { _, value in
            value.send(completion: .finished)
        }
        self.objectPublishers = [:]
    }
}
