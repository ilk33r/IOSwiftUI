//
//  ViewFontExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import SwiftUI

public extension View {
    
    @inlinable func font(type: IOFontTypes) -> some View {
        return self.font(type.rawValue)
    }
}
