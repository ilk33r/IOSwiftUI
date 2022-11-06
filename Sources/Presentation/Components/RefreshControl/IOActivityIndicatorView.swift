//
//  IOActivityIndicatorView.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.10.2022.
//

import Foundation
import SwiftUI
import UIKit

public struct IOActivityIndicatorView: UIViewRepresentable {

    // MARK: - Defs
    
    public typealias Configuration = (_ view: UIActivityIndicatorView) -> Void
    public typealias UIViewType = UIActivityIndicatorView
  
    // MARK: - Privates
    
    private var isAnimating: Bool!
    private var configuration: Configuration?

    // MARK: - Initialization Methods
    
    public init(isAnimating: Bool, configuration: Configuration? = nil) {
        self.isAnimating = isAnimating
        self.configuration = configuration
    }

    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
        
        configuration?(uiView)
    }
}
