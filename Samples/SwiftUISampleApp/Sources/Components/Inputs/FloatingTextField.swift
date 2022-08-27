//
//  SwiftUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUIComponents
import SwiftUISampleAppResources

public struct FloatingTextField: View {
    
    @Binding private var isEditingBinder: Bool
    @Binding private var text: String
    @State private var isEditing = false
    
    private var keyboardType: UIKeyboardType
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        IOFloatingTextField(
            localizationType,
            text: $text,
            keyboardType: self.keyboardType,
            textFieldOverlay: {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(height: 52)
            }
        )
        .textColor(Color.black)
        .placeholderColor(Color.colorPlaceholder)
        .backgroundColor(Color.white)
        .activePlaceholderPadding(EdgeInsets(top: 0, leading: 12, bottom: 52, trailing: 0))
        .placeholderPadding(EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0))
        .padding(.top, 8)
        .frame(height: 60)
    }
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>
    ) {
        self.keyboardType = .default
        self.localizationType = l
        self._text = text
        self._isEditingBinder = Binding.constant(false)
    }
    
    private init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType,
        editingBinder: Binding<Bool>
    ) {
        self.keyboardType = keyboardType
        self.localizationType = l
        self._text = text
        self._isEditingBinder = editingBinder
    }
    
    public func keyboardType(_ type: UIKeyboardType) -> FloatingTextField {
        return FloatingTextField(
            localizationType,
            text: $text,
            keyboardType: type,
            editingBinder: $isEditingBinder
        )
    }
    
    public func editingHandler(isEditing: Binding<Bool>) -> FloatingTextField {
        return FloatingTextField(
            localizationType,
            text: $text,
            keyboardType: keyboardType,
            editingBinder: isEditing
        )
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    
    struct FloatingTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            FloatingTextField(
                .init(rawValue: "Email address"),
                text: $emailAddress
            )
            .padding(20)
        }
    }
    
    static var previews: some View {
        FloatingTextFieldDemo()
    }
}
