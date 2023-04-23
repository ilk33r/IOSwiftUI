//
//  SecureFloatingTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppResources

public struct SecureFloatingTextField: View, IOValidatable {
    
    // MARK: - Identifiable
    
    public var id = UUID().uuidString
    public var validationText: String? { text }
    
    // MARK: - Privates
    
    @Binding private var isEditingBinder: Bool
    @Binding private var text: String
    @ObservedObject private var validationObservedObject = IOValidatorObservedObject()
    @State private var isEditing = false
    
    private let localizationType: IOLocalizationType
    private let capitalization: UITextAutocapitalizationType
    private let disableAutocorrection: Bool
    private let keyboardType: UIKeyboardType
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading) {
            IOSecureFloatingTextField(
                localizationType,
                text: $text,
                keyboardType: keyboardType,
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
            .font(type: .regular(14))
            .padding(.top, 8)
            .frame(height: 60)
            Text(validationObservedObject.errorMessage)
                .font(type: .regular(12))
                .foregroundColor(.colorTabEnd)
                .padding(.top, 4)
                .hidden(isHidden: $validationObservedObject.isValidated)
        }
    }
    
    // MARK: - Initialization Methods
    
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
    
    // MARK: - Modifiers
    
    public func capitalization(_ type: UITextAutocapitalizationType) -> SecureFloatingTextField {
        Self(
            localizationType,
            text: $text,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            disableAutocorrection: disableAutocorrection,
            capitalization: type
        )
    }
    
    public func disableCorrection(_ correction: Bool) -> SecureFloatingTextField {
        Self(
            localizationType,
            text: $text,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            disableAutocorrection: correction,
            capitalization: capitalization
        )
    }
    
    public func keyboardType(_ type: UIKeyboardType) -> SecureFloatingTextField {
        Self(
            localizationType,
            text: $text,
            keyboardType: type,
            editingBinder: $isEditingBinder,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func editingHandler(isEditing: Binding<Bool>) -> SecureFloatingTextField {
        Self(
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
        validationObservedObject
    }
}

#if DEBUG
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
        prepare()
        return FloatingTextFieldDemo()
    }
}
#endif
