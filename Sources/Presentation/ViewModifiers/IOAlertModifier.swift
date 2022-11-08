//
//  IOAlertModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 8.11.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure

public struct IOAlertData {
    
    let title: String
    let message: String
    let buttons: [IOLocalizationType]
    let handler: IOAlertModifierResultHandler?
    
    public init(title: String, message: String, buttons: [IOLocalizationType], handler: IOAlertModifierResultHandler?) {
        self.title = title
        self.message = message
        self.buttons = buttons
        self.handler = handler
    }
}

public typealias IOAlertModifierHandler = () -> IOAlertData
public typealias IOAlertModifierResultHandler = (_ index: Int) -> Void

public extension View {
    
    func alertView(
        isPresented: Binding<Bool>,
        handler: @escaping IOAlertModifierHandler
    ) -> some View {
        modifier(IOAlertModifier(isPresented: isPresented, handler: handler))
    }
}

struct IOAlertModifier: ViewModifier {
    
    private let isPresented: Binding<Bool>
    private let handler: IOAlertModifierHandler
    
    init(
        isPresented: Binding<Bool>,
        handler: @escaping IOAlertModifierHandler
    ) {
        self.isPresented = isPresented
        self.handler = handler
    }
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: isPresented) {
                let alertContent = handler()
                
                if alertContent.buttons.count > 1 {
                    return Alert(
                        title: Text(alertContent.title),
                        message: Text(alertContent.message),
                        primaryButton: .default(
                            Text(alertContent.buttons[0].localized),
                            action: {
                                alertContent.handler?(0)
                            }
                        ),
                        secondaryButton: .destructive(
                            Text(alertContent.buttons[1].localized),
                            action: {
                                alertContent.handler?(1)
                            }
                        )
                    )
                } else {
                    return Alert(
                        title: Text(alertContent.title),
                        message: Text(alertContent.message),
                        dismissButton: .default(
                            Text(alertContent.buttons[0].localized),
                            action: {
                                alertContent.handler?(0)
                            }
                        )
                    )
                }
            }
    }
}
