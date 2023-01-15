//
//  IOHTMLText.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.01.2023.
//

import Foundation
import SwiftUI

public struct IOHTMLText: UIViewRepresentable {

    // MARK: - Defs
    
    public typealias Configuration = (_ view: IOHTMLTextUIView) -> Void
    public typealias UIViewType = IOHTMLTextUIView
  
    // MARK: - Privates
    
    private var isAnimating: Bool!
    private var configuration: Configuration?

    // MARK: - Initialization Methods
    
    public init(configuration: Configuration? = nil) {
        self.configuration = configuration
    }

    public func makeUIView(context: Context) -> IOHTMLTextUIView {
        return IOHTMLTextUIView()
    }
    
    public func updateUIView(_ uiView: IOHTMLTextUIView, context: Context) {
        configuration?(uiView)
    }
}
