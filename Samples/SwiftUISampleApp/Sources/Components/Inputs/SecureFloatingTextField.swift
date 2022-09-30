//
//  SecureFloatingTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import IOSwiftUIComponents
import SwiftUISampleAppResources

public struct SecureFloatingTextField: View, IOValidatable {
    
    public var validationText: String? { self.text }
    
    @Binding private var isEditingBinder: Bool
    @Binding private var text: String
    @ObservedObject private var validationObservedObject = IOValidatorObservedObject()
    @State private var isEditing = false
    
    private var capitalization: UITextAutocapitalizationType
    private var disableAutocorrection: Bool
    private var keyboardType: UIKeyboardType
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        VStack(alignment: .leading) {
            IOSecureFloatingTextField(
                localizationType,
                text: $text,
                keyboardType: self.keyboardType,
                textFieldOverlay: {
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(height: 52)
                }
            )
            .disableCorrection(true)
            .capitalization(capitalization)
            .textColor(Color.black)
            .placeholderColor(Color.colorPlaceholder)
            .backgroundColor(Color.white)
            .activePlaceholderPadding(EdgeInsets(top: 0, leading: 12, bottom: 52, trailing: 0))
            .placeholderPadding(EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0))
            .padding(.top, 8)
            .frame(height: 60)
            Text(validationObservedObject.errorMessage)
                .font(type: .regular(12))
                .foregroundColor(.colorTabEnd)
                .padding(.top, 4)
                .hidden(isHidden: $validationObservedObject.isValidated)
        }
    }
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>
    ) {
        self.keyboardType = .default
        self.localizationType = l
        self._text = text
        self._isEditingBinder = Binding.constant(false)
        self.disableAutocorrection = false
        self.capitalization = .words
    }
    
    private init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType,
        editingBinder: Binding<Bool>,
        disableAutocorrection: Bool,
        capitalization: UITextAutocapitalizationType
    ) {
        self.keyboardType = keyboardType
        self.localizationType = l
        self._text = text
        self._isEditingBinder = editingBinder
        self.disableAutocorrection = disableAutocorrection
        self.capitalization = capitalization
    }
    
    public func capitalization(_ type: UITextAutocapitalizationType) -> SecureFloatingTextField {
        return SecureFloatingTextField(
            localizationType,
            text: $text,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            disableAutocorrection: disableAutocorrection,
            capitalization: type
        )
    }
    
    public func disableCorrection(_ correction: Bool) -> SecureFloatingTextField {
        return SecureFloatingTextField(
            localizationType,
            text: $text,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            disableAutocorrection: correction,
            capitalization: capitalization
        )
    }
    
    public func keyboardType(_ type: UIKeyboardType) -> SecureFloatingTextField {
        return SecureFloatingTextField(
            localizationType,
            text: $text,
            keyboardType: type,
            editingBinder: $isEditingBinder,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func editingHandler(isEditing: Binding<Bool>) -> SecureFloatingTextField {
        return SecureFloatingTextField(
            localizationType,
            text: $text,
            keyboardType: keyboardType,
            editingBinder: isEditing,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    // MARK: - Validation
    
    public func observedObject() -> IOValidatorObservedObject {
        return validationObservedObject
    }
}

struct SecureFloatingTextField_Previews: PreviewProvider {
    
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
