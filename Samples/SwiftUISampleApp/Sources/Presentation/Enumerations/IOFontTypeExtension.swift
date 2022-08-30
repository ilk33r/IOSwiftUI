//
//  IOFontTypeExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

public extension IOFontType {
    
    static let bold: FontWithSize = { IOFontType(rawValue: Font.custom("Roboto-Bold", size: $0)) }
    static let black: FontWithSize = { IOFontType(rawValue: Font.custom("Roboto-Black", size: $0)) }
    static let medium: FontWithSize = { IOFontType(rawValue: Font.custom("Roboto-Medium", size: $0)) }
    static let regular: FontWithSize = { IOFontType(rawValue: Font.custom("Roboto-Regular", size: $0)) }
    static let thin: FontWithSize = { IOFontType(rawValue: Font.custom("Roboto-Thin", size: $0)) }
}
