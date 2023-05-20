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
    
    public var id: String
    public var validationText: String? { text }
    
    // MARK: - Privates
    
    private let title: String
    private let capitalization: UITextAutocapitalizationType
    private let disableAutocorrection: Bool
    private let keyboardType: UIKeyboardType
    
    @Binding private var isEditingBinder: Bool
    @Binding private var text: String
    
    @ObservedObject private var validationObservedObject = IOValidatorObservedObject()
    
    @State private var isEditing = false
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading) {
            IOSecureFloatingTextField(
                title,
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
        text: Binding<String>,
        validationId: String = "SecureFloatingTextField"
    ) {
        self.init(
            l.localized,
            text: text,
            validationId: validationId
        )
    }
    
    public init(
        _ title: String,
        text: Binding<String>,
        validationId: String = "SecureFloatingTextField"
    ) {
        self.keyboardType = .default
        self.title = title
        self._text = text
        self.id = validationId
        self._isEditingBinder = Binding.constant(false)
        self.disableAutocorrection = false
        self.capitalization = .words
    }
    
    private init(
        _ title: String,
        text: Binding<String>,
        validationId: String,
        keyboardType: UIKeyboardType,
        editingBinder: Binding<Bool>,
        disableAutocorrection: Bool,
        capitalization: UITextAutocapitalizationType
    ) {
        self.keyboardType = keyboardType
        self.title = title
        self._text = text
        self.id = validationId
        self._isEditingBinder = editingBinder
        self.disableAutocorrection = disableAutocorrection
        self.capitalization = capitalization
    }
    
    // MARK: - Validation
    
    public func observedObject() -> IOValidatorObservedObject {
        validationObservedObject
    }
}

public extension SecureFloatingTextField {
    
    // MARK: - Modifiers
    
    func capitalization(_ type: UITextAutocapitalizationType) -> SecureFloatingTextField {
        Self(
            title,
            text: $text,
            validationId: id,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            disableAutocorrection: disableAutocorrection,
            capitalization: type
        )
    }
    
    func disableCorrection(_ correction: Bool) -> SecureFloatingTextField {
        Self(
            title,
            text: $text,
            validationId: id,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            disableAutocorrection: correction,
            capitalization: capitalization
        )
    }
    
    func keyboardType(_ type: UIKeyboardType) -> SecureFloatingTextField {
        Self(
            title,
            text: $text,
            validationId: id,
            keyboardType: type,
            editingBinder: $isEditingBinder,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    func editingHandler(isEditing: Binding<Bool>) -> SecureFloatingTextField {
        Self(
            title,
            text: $text,
            validationId: id,
            keyboardType: keyboardType,
            editingBinder: isEditing,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
}

#if DEBUG
struct SecureFloatingTextField_Previews: PreviewProvider {
    
    struct SecureFloatingTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            SecureFloatingTextField(
                "Email address",
                text: $emailAddress
            )
            .padding(20)
        }
    }
    
    static var previews: some View {
        prepare()
        return SecureFloatingTextFieldDemo()
    }
}
#endif
