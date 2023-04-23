//
//  IOConstraints.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import UIKit

public struct IOConstraints: RawRepresentable {
    
    public enum ConstraintType {
        case safeAreaTop
        case safeAreaTrailing
        case safeAreaLeading
        case safeAreaBottom
        case top
        case trailing
        case leading
        case bottom
        case centerX
        case centerY
        case equalWidth
        case equalHeight
    }
    
    public typealias ConstraintWithValue = (_ value: CGFloat) -> IOConstraints
    public let rawValue: ConstraintType
    public let sizeValue: CGFloat
    
    public static let safeAreaTop: ConstraintWithValue = { Self(rawValue: .safeAreaTop, sizeValue: $0) }
    public static let safeAreaTrailing: ConstraintWithValue = { Self(rawValue: .safeAreaTrailing, sizeValue: $0) }
    public static let safeAreaLeading: ConstraintWithValue = { Self(rawValue: .safeAreaLeading, sizeValue: $0) }
    public static let safeAreaBottom: ConstraintWithValue = { Self(rawValue: .safeAreaBottom, sizeValue: $0) }
    
    public static let top: ConstraintWithValue = { Self(rawValue: .top, sizeValue: $0) }
    public static let trailing: ConstraintWithValue = { Self(rawValue: .trailing, sizeValue: $0) }
    public static let leading: ConstraintWithValue = { Self(rawValue: .leading, sizeValue: $0) }
    public static let bottom: ConstraintWithValue = { Self(rawValue: .bottom, sizeValue: $0) }
    
    public static let centerX: ConstraintWithValue = { Self(rawValue: .centerX, sizeValue: $0) }
    public static let centerY: ConstraintWithValue = { Self(rawValue: .centerY, sizeValue: $0) }
    
    public static let equalWidth: ConstraintWithValue = { Self(rawValue: .equalWidth, sizeValue: $0) }
    public static let equalHeight: ConstraintWithValue = { Self(rawValue: .equalHeight, sizeValue: $0) }
    
    public static let safeAreaAll: [IOConstraints] = [.safeAreaTop(0), .safeAreaTrailing(0), .safeAreaLeading(0), .safeAreaBottom(0)]
    public static let all: [IOConstraints] = [.top(0), .trailing(0), .leading(0), .bottom(0)]
    
    public init(rawValue: ConstraintType) {
        self.rawValue = rawValue
        self.sizeValue = 0
    }
    
    public init(rawValue: ConstraintType, sizeValue: CGFloat) {
        self.rawValue = rawValue
        self.sizeValue = sizeValue
    }
}
