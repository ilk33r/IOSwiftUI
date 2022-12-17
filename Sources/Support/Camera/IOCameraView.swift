//
//  IOCameraView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import SwiftUI
import UIKit

public struct IOCameraView: UIViewRepresentable {

    // MARK: - Defs
    
    public typealias Configuration = (_ view: IOCameraUIView) -> Void
    public typealias UIViewType = IOCameraUIView
  
    // MARK: - Privates
    
    private var configuration: Configuration?

    // MARK: - Initialization Methods
    
    public init(configuration: Configuration? = nil) {
        self.configuration = configuration
    }

    public func makeUIView(context: Context) -> IOCameraUIView {
        return IOCameraUIView()
    }
    
    public func updateUIView(_ uiView: IOCameraUIView, context: Context) {
        configuration?(uiView)
    }
}
