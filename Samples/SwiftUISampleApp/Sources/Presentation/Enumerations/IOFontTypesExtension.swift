//
//  IOFontTypesExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

public extension IOFontTypes {
    
    static let black: FontWithSize = { IOFontTypes(rawValue: Font.custom("Roboto-Black", size: $0)) }
}
