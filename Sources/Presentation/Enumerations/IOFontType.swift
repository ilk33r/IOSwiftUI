//
//  IOFontType.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import SwiftUI

public struct IOFontType: RawRepresentable {
    
    public typealias FontWithSize = (_ size: CGFloat) -> IOFontType
    public typealias RawValue = Font

    public static let systemRegular: FontWithSize = { Self(rawValue: Font.system(size: $0).weight(.regular)) }
    public static let systemSemibold: FontWithSize = { Self(rawValue: Font.system(size: $0).weight(.semibold)) }
    
    public var rawValue: Font
    
    public init(rawValue: Font) {
        self.rawValue = rawValue
    }
}
