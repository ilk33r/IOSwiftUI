//
//  IOFormGroup.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOFormGroup<Content>: View where Content: View {
    
    public typealias ClickHandler = () -> Void
    
    private var localizationType: IOLocalizationType
    private var clickHandler: ClickHandler?
    private var contentView: Content
    
    public var body: some View {
        if #available(iOS 15.0, *) {
            self.contentView
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(localizationType.localized) {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            self.clickHandler?()
                        }
                    }
                }
        } else {
            self.contentView
        }
    }
    
    public init(_ l: IOLocalizationType, handler: ClickHandler?, @ViewBuilder content: () -> Content) {
        self.localizationType = l
        self.clickHandler = handler
        self.contentView = content()
    }
}
