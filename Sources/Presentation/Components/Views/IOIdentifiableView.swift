//
//  IOIdentifiableView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import SwiftUI

public struct IOIdentifiableView: Identifiable {
    
    public let id = UUID()
    public let view: AnyView
    
    public init<Content: View>(view: Content) {
        self.view = AnyView(view)
    }
    
    public init(anyView: AnyView) {
        self.view = anyView
    }
}
