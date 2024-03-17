//
//  CartManager.swift
//
//
//  Created by Adnan ilker Ozcan on 17.03.2024.
//

import Combine
import Foundation

public typealias CartHandler = (_ imagePublicId: String) -> Void

public protocol CartManager {
    
    var cartChangePublisher: AnyPublisher<Any?, Never> { get }
    var objects: [String] { get }
    
    func clear()
    
    func add(toCart imagePublicId: String)
    func remove(fromCart imagePublicId: String)
    
    func toCartData(data: Any?) -> [String]
}
