//
//  IONavigationLinkView.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import SwiftUI

public protocol IONavigationLinkView: View {
    
    // MARK: - Generics
    
    associatedtype LinkBody: View
    
    // MARK: - Properties
    
    @ViewBuilder var linkBody: Self.LinkBody { get }
}

public extension IONavigationLinkView {
    
    var body: some View {
        self.linkBody
    }
}
