//
//  ViewFontExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import SwiftUI

public extension View {
    
    @inlinable func font(type: IOFontType) -> some View {
        return font(type.rawValue)
    }
}
