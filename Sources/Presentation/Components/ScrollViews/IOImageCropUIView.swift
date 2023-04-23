//
//  IOImageCropUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.02.2023.
//

import Foundation
import SwiftUI

public struct IOImageCropUIView: UIViewRepresentable {
    
    // MARK: - Defs
    
    public typealias Configuration = (_ view: IOImageCropUIScrollView) -> Void
    public typealias UIViewType = IOImageCropUIScrollView
  
    // MARK: - Privates
    
    private var configuration: Configuration?

    // MARK: - Initialization Methods
    
    public init(configuration: Configuration?) {
        self.configuration = configuration
    }

    public func makeUIView(context: Context) -> IOImageCropUIScrollView {
        IOImageCropUIScrollView()
    }
    
    public func updateUIView(_ uiView: IOImageCropUIScrollView, context: Context) {
        configuration?(uiView)
    }
}
