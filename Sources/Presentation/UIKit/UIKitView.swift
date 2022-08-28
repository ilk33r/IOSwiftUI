//
//  UIKitView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import SwiftUI

final public class UIKitView<TView: UIResponder>: UIViewRepresentable {
    
    // MARK: - Defs
    
    public typealias Handler = (_ view: TView) -> Void
    
    // MARK: - Privates
    
    private var handler: Handler?
    
    // MARK: - Initialization Methods
    
    public init(type: TView.Type, _ handler: Handler?) {
        self.handler = handler
    }
    
    // MARK: - Representable
    
    public func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        if let view = uiView.next(TView.self) {
            self.handler?(view)
        }
    }
}
