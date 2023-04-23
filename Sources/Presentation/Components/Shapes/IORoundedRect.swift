//
//  IORoundedRect.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import SwiftUI

public struct IORoundedRect: Shape {
    
    // MARK: - Defs
    
    public struct Corner: RawRepresentable {
        
        public enum CornerType {
            case topLeft
            case topRight
            case bottomLeft
            case bottomRight
        }
        
        public typealias CornerWithValue = (_ value: CGFloat) -> Corner
        public let rawValue: CornerType
        public let sizeValue: CGFloat
        
        public static let topLeft: CornerWithValue = { Self(rawValue: .topLeft, sizeValue: $0) }
        public static let topRight: CornerWithValue = { Self(rawValue: .topRight, sizeValue: $0) }
        public static let bottomLeft: CornerWithValue = { Self(rawValue: .bottomLeft, sizeValue: $0) }
        public static let bottomRight: CornerWithValue = { Self(rawValue: .bottomRight, sizeValue: $0) }
        
        public init(rawValue: CornerType) {
            self.rawValue = rawValue
            self.sizeValue = 0
        }
        
        public init(rawValue: CornerType, sizeValue: CGFloat) {
            self.rawValue = rawValue
            self.sizeValue = sizeValue
        }
    }
    
    // MARK: - Privates
    
    private var corners: [Corner]
    
    // MARK: - Initialization Methods
    
    public init(corners: [Corner]) {
        self.corners = corners
    }
    
    // MARK: - Drawing
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
                
        let width = rect.size.width
        let height = rect.size.height
                
        // Make sure we do not exceed the size of the rectangle
        var topLeft: CGFloat = 0
        var topRight: CGFloat = 0
        var bottomLeft: CGFloat = 0
        var bottomRight: CGFloat = 0
        
        corners.forEach { corner in
            if corner.rawValue == .topLeft {
                topLeft = corner.sizeValue
            }
            
            if corner.rawValue == .topRight {
                topRight = corner.sizeValue
            }
            
            if corner.rawValue == .bottomLeft {
                bottomLeft = corner.sizeValue
            }
            
            if corner.rawValue == .bottomRight {
                bottomRight = corner.sizeValue
            }
        }
                
        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(
            center: CGPoint(x: width - topRight, y: topRight),
            radius: topRight,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
                
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(
            center: CGPoint(x: width - bottomRight, y: height - bottomRight),
            radius: bottomRight,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 90),
            clockwise: false
        )
                
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(
            center: CGPoint(x: bottomLeft, y: height - bottomLeft),
            radius: bottomLeft,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 180),
            clockwise: false
        )
                
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(
            center: CGPoint(x: topLeft, y: topLeft),
            radius: topLeft,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        
        path.closeSubpath()
        return path
    }
}
