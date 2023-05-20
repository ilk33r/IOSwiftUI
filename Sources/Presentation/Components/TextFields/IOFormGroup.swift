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
    
    // MARK: - Defs
    
    public typealias ClickHandler = () -> Void
    
    // MARK: - Privates
    
    private let title: String
    private let clickHandler: ClickHandler?
    private let contentView: Content
    
    // MARK: - Body
    
    public var body: some View {
        if #available(iOS 15.0, *) {
            contentView
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(title) {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            clickHandler?()
                        }
                    }
                }
        } else {
            contentView
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        handler: ClickHandler?,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            l.localized,
            handler: handler,
            content: content
        )
    }
    
    public init(
        _ title: String,
        handler: ClickHandler?,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.clickHandler = handler
        self.contentView = content()
    }
}

#if DEBUG
struct IOFormGroup_Previews: PreviewProvider {
    
    struct IOFormGroupDemo: View {
        
        @State var emailAddress: String = ""
        
        var body: some View {
            IOFormGroup("Done") {
                
            } content: {
                TextField("Email address", text: $emailAddress)
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return IOFormGroupDemo()
    }
}
#endif
