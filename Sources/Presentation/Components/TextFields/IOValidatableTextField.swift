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
    
    public var id = UUID().uuidString
    
    // MARK: - Privates
    
    private let localizationType: IOLocalizationType
    
    private var changeHandler: IOTextField.ChangeHandler?
    private var keyboardType: UIKeyboardType
    
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
        IOTextField(
            localizationType,
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
    
    struct TextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOValidatableTextField(.init(rawValue: "Email address"), text: $emailAddress)
                .padding(20)
        }
    }
    
    static var previews: some View {
        prepare()
        return Group {
            TextFieldDemo()
        }
        .previewLayout(.fixed(width: 320, height: 70))
    }
}
#endif
