//
//  IOValidatableTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.09.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

public struct IOValidatableTextField: View, IOValidatable {
    
    // MARK: - Publics
    
    public var validationText: String? { self.text }
    
    // MARK: - Privates
    
    private var changeHandler: IOTextField.ChangeHandler?
    private var keyboardType: UIKeyboardType
    private var localizationType: IOLocalizationType
    
    @Binding private var text: String
    @ObservedObject private var validationObservedObject = IOValidatorObservedObject()
    
    public var body: some View {
        VStack {
            IOTextField(localizationType, text: $text)
            Text(validationObservedObject.errorMessage)
                .hidden(isHidden: $validationObservedObject.isValidated)
        }
    }
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        changeHandler: IOTextField.ChangeHandler? = nil
    ) {
        self.keyboardType = keyboardType
        self.localizationType = l
        self._text = text
    }
    
    public func keyboardType(_ type: UIKeyboardType) -> IOTextField {
        return IOTextField(
            localizationType,
            text: $text,
            keyboardType: type
        )
    }
    
    // MARK: - Validation
    
    public func observedObject() -> IOValidatorObservedObject {
        return validationObservedObject
    }
}

struct IOValidatableTextField_Previews: PreviewProvider {
    
    struct TextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOValidatableTextField(.init(rawValue: "Email address"), text: $emailAddress)
                .padding(20)
        }
    }
    
    static var previews: some View {
        Group {
            TextFieldDemo()
        }
        .previewLayout(.fixed(width: 320, height: 70))
    }
}
