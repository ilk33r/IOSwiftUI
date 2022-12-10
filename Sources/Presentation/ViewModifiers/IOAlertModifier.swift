//
//  IOAlertModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 8.11.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure

public extension View {
    
    @ViewBuilder
    func alertView(
        isPresented: Binding<Bool>,
        handler: @escaping IOAlertHandler
    ) -> some View {
        modifier(IOAlertModifier(isPresented: isPresented, handler: handler))
    }
}

struct IOAlertModifier: ViewModifier {
    
    private let isPresented: Binding<Bool>
    private let handler: IOAlertHandler
    
    init(
        isPresented: Binding<Bool>,
        handler: @escaping IOAlertHandler
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
                        title: Text(alertContent.title ?? ""),
                        message: Text(alertContent.message),
                        primaryButton: .default(
                            Text(alertContent.buttons[0]),
                            action: {
                                alertContent.handler?(0)
                            }
                        ),
                        secondaryButton: .destructive(
                            Text(alertContent.buttons[1]),
                            action: {
                                alertContent.handler?(1)
                            }
                        )
                    )
                } else {
                    return Alert(
                        title: Text(alertContent.title ?? ""),
                        message: Text(alertContent.message),
                        dismissButton: .default(
                            Text(alertContent.buttons[0]),
                            action: {
                                alertContent.handler?(0)
                            }
                        )
                    )
                }
            }
    }
}
