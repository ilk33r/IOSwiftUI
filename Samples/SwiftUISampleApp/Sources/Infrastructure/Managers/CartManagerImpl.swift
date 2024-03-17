//
//  CartManagerImpl.swift
//
//
//  Created by Adnan ilker Ozcan on 17.03.2024.
//

import Combine
import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure

private extension IOPublisherType {
    
    static let cartChangePublisher = IOPublisherType(rawValue: "cartChangePublisher")
}

private extension IOStorageType {
    
    static let cartObjects = IOStorageType(rawValue: "cartObjects")
}

public struct CartManagerImpl: IOSingleton, CartManager {

    // MARK: - DI
    
    public typealias InstanceType = CartManagerImpl
    
    public static var _sharedInstance: CartManagerImpl!
    
    @IOInject private var appState: IOAppState
    @IOInject private var eventProcess: IOEventProcess
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Properties
    
    public var cartChangePublisher: AnyPublisher<Any?, Never> {
        eventProcess.object(forType: .cartChangePublisher)
    }
    
    public var objects: [String] {
        let cartObjects = appState.object(forType: .cartObjects) as? [String]
        return cartObjects ?? []
    }
    
    // MARK: - Manager Methods
    
    public func clear() {
        appState.remove(type: .cartObjects)
        eventProcess.set(object: objects, forType: .cartChangePublisher)
    }
    
    public func add(toCart imagePublicId: String) {
        var cartObjects = objects
        let imagePublicIdInCardObject = cartObjects.first(where: { $0 == imagePublicId })
        if imagePublicIdInCardObject != nil {
            return
        }
        cartObjects.append(imagePublicId)
        appState.set(object: cartObjects, forType: .cartObjects)
        eventProcess.set(object: cartObjects, forType: .cartChangePublisher)
    }
    
    public func remove(fromCart imagePublicId: String) {
        var cartObjects = objects
        cartObjects.removeAll(where: { $0 == imagePublicId })
        appState.set(object: cartObjects, forType: .cartObjects)
        eventProcess.set(object: cartObjects, forType: .cartChangePublisher)
    }
    
    public func toCartData(data: Any?) -> [String] {
        if let cartData = data as? [String] {
            return cartData
        }
        
        return []
    }
}
