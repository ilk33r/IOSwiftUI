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
    
    private let localizationType: IOLocalizationType
    
    private var changeHandler: ChangeHandler?
    private var keyboardType: UIKeyboardType
    
    @Binding var text: String
    
    public var body: some View {
        TextField(localizationType.localized(alternateText: ""), text: $text) { isEditing in
            changeHandler?(isEditing)
        }
        .keyboardType(keyboardType)
    }
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        changeHandler: ChangeHandler? = nil
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
}

struct IOTextFieldd_Previews: PreviewProvider {
    
    struct TextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOTextField(.init(rawValue: "Email address"), text: $emailAddress)
                .padding(20)
        }
    }
    
    static var previews: some View {
        prepare()
        return Group {
            TextFieldDemo()
        }
        .previewLayout(.fixed(width: 320, height: 52))
    }
}
