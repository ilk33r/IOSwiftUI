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
    
    @Binding private var link: URL?
    
    private var isAnimating: Bool!
    private var configuration: Configuration?

    // MARK: - Initialization Methods
    
    public init(
        link: Binding<URL?> = Binding.constant(nil),
        configuration: Configuration? = nil
    ) {
        self._link = link
        self.configuration = configuration
    }

    public func makeUIView(context: Context) -> IOHTMLTextUIView {
        return IOHTMLTextUIView { link in
            self.link = link
        }
    }
    
    public func updateUIView(_ uiView: IOHTMLTextUIView, context: Context) {
        configuration?(uiView)
    }
}
