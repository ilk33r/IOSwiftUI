//
//  IOClickable.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import SwiftUI

public typealias IOClickableHandler = () -> Void

public protocol IOClickable where Self: View {
    
    var handler: IOClickableHandler? { get set }
    
    func setClick(_ handler: IOClickableHandler?) -> Self
}
