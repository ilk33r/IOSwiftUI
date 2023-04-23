//
//  IOButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOButton<Content>: View, IOClickable where Content: View {
    
    public var handler: IOClickableHandler?
    private var localizationType: IOLocalizationType?
    private var content: (() -> Content)?
    
    public var body: some View {
        if let localizationType {
            Button(localizationType.localized) {
                handler?()
            }
        } else {
            Button {
                handler?()
            } label: {
                content?()
            }
        }
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    private init(
        _ l: IOLocalizationType?,
        content: (() -> Content)?,
        handler: IOClickableHandler?
    ) {
        self.localizationType = l
        self.content = content
        self.handler = handler
    }
    
    public func setClick(
        _ handler: IOClickableHandler?
    ) -> IOButton {
        Self(
            localizationType,
            content: content,
            handler: handler
        )
    }
}

public extension IOButton where Content == Never {
    
    init(
        _ l: IOLocalizationType
    ) {
        self.localizationType = l
    }
}

#if DEBUG
struct IOButton_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return Group {
            IOButton(.init(rawValue: "Button"))
        }
    }
}
#endif
