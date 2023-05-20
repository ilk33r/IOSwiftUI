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
    
    // MARK: - Privates
    
    public var handler: IOClickableHandler?
    private let content: (() -> Content)?
    private let title: String?
    
    // MARK: - Body
    
    public var body: some View {
        if let title {
            Button(title) {
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
    
    // MARK: - Initialization Methods
    
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = nil
        self.content = content
    }
    
    private init(
        _ title: String?,
        content: (() -> Content)?,
        handler: IOClickableHandler?
    ) {
        self.title = title
        self.content = content
        self.handler = handler
    }
    
    // MARK: - Modifiers
    
    public func setClick(
        _ handler: IOClickableHandler?
    ) -> IOButton {
        Self(
            title,
            content: content,
            handler: handler
        )
    }
}

public extension IOButton where Content == Never {
    
    init(
        _ l: IOLocalizationType
    ) {
        self.title = l.localized
        self.content = nil
    }
    
    init(
        _ title: String
    ) {
        self.title = title
        self.content = nil
    }
}

#if DEBUG
struct IOButton_Previews: PreviewProvider {
    
    struct IOButtonDemo: View {
        
        var body: some View {
            IOButton("Button")
        }
    }
    
    static var previews: some View {
        prepare()
        return IOButtonDemo()
    }
}
#endif
