//
//  IOEditTextView.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.01.2023.
//

import Foundation
import SwiftUI

public struct IOEditTextView: UIViewRepresentable {

    // MARK: - Defs
    
    public typealias Configuration = (_ view: IOEditTextUIView) -> Void
    public typealias UIViewType = IOEditTextUIView
  
    // MARK: - Privates
    
    @Binding private var text: String
    
    private var isAnimating: Bool!
    private var configuration: Configuration?

    // MARK: - Initialization Methods
    
    public init(
        text: Binding<String> = Binding.constant(""),
        configuration: Configuration? = nil
    ) {
        self._text = text
        self.configuration = configuration
    }

    public func makeUIView(context: Context) -> IOEditTextUIView {
        return IOEditTextUIView { text in
            self.text = text
        }
    }
    
    public func updateUIView(_ uiView: IOEditTextUIView, context: Context) {
        configuration?(uiView)
    }
}
