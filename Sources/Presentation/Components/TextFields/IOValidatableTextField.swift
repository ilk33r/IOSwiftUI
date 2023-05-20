//
//  IOValidatableTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import IOSwiftUIInfrastructure
import SwiftUI

public struct IOValidatableTextField: View, IOValidatable {
    
    // MARK: - Publics
    
    public var validationText: String? { text }
    
    // MARK: - Identifiable
    
    public var id: String
    
    // MARK: - Privates
    
    private let title: String
    private let changeHandler: IOTextField.ChangeHandler?
    private let keyboardType: UIKeyboardType
    
    @Binding private var text: String
    @ObservedObject private var validationObservedObject = IOValidatorObservedObject()
    
    // MARK: - Body
    
    public var body: some View {
        VStack {
            IOTextField(title, text: $text)
            Text(validationObservedObject.errorMessage)
                .hidden(isHidden: $validationObservedObject.isValidated)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        validationId: String = "IOValidatableTextField",
        changeHandler: IOTextField.ChangeHandler? = nil
    ) {
        self.init(
            l.localized,
            text: text,
            keyboardType: keyboardType,
            validationId: validationId,
            changeHandler: changeHandler
        )
    }
    
    public init(
        _ title: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        validationId: String = "IOValidatableTextField",
        changeHandler: IOTextField.ChangeHandler? = nil
    ) {
        self.keyboardType = keyboardType
        self.title = title
        self.id = validationId
        self.changeHandler = changeHandler
        self._text = text
    }
    
    // MARK: - Modifiers
    
    public func keyboardType(_ type: UIKeyboardType) -> IOTextField {
        IOTextField(
            title,
            text: $text,
            keyboardType: type
        )
    }
    
    // MARK: - Validation
    
    public func observedObject() -> IOValidatorObservedObject {
        validationObservedObject
    }
}

#if DEBUG
struct IOValidatableTextField_Previews: PreviewProvider {
    
    struct IOValidatableTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOValidatableTextField(.init(rawValue: "Email address"), text: $emailAddress)
                .padding(20)
        }
    }
    
    static var previews: some View {
        prepare()
        return IOValidatableTextFieldDemo()
    }
}
#endif
