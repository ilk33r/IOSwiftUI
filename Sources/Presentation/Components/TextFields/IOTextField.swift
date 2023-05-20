//
//  IOTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOTextField: View {
    
    // MARK: - Defs
    
    public typealias ChangeHandler = (_ isEditing: Bool) -> Void
    
    // MARK: - Privates
    
    private let title: String
    private let changeHandler: ChangeHandler?
    private let keyboardType: UIKeyboardType
    
    @Binding var text: String
    
    // MARK: - Body
    
    public var body: some View {
        TextField(title, text: $text) { isEditing in
            changeHandler?(isEditing)
        }
        .keyboardType(keyboardType)
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        changeHandler: ChangeHandler? = nil
    ) {
        self.init(
            l.localized,
            text: text,
            keyboardType: keyboardType,
            changeHandler: changeHandler
        )
    }
    
    public init(
        _ title: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        changeHandler: ChangeHandler? = nil
    ) {
        self.keyboardType = keyboardType
        self.title = title
        self.changeHandler = changeHandler
        self._text = text
    }
    
    // MARK: - Modifiers
    
    public func keyboardType(_ type: UIKeyboardType) -> IOTextField {
        Self(
            title,
            text: $text,
            keyboardType: type
        )
    }
}

#if DEBUG
struct IOTextField_Previews: PreviewProvider {
    
    struct IOTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOTextField("Email address", text: $emailAddress)
                .padding(20)
        }
    }
    
    static var previews: some View {
        prepare()
        return IOTextFieldDemo()
    }
}
#endif
