//
//  OTPTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import Foundation
import SwiftUI
import IOSwiftUIPresentation

public struct OTPTextField: View, IOValidatable {
    
    // MARK: - Identifiable
    
    public var id = UUID().uuidString
    public var validationText: String? { text }
    
    // MARK: - Privates
    
    @Binding private var text: String
    @ObservedObject private var validationObservedObject = IOValidatorObservedObject()
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading) {
            IOOTPTextField(
                text: $text,
                maxLength: 6,
                overlayWidth: 46
            ) {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(height: 52)
            }
            .font(type: .regular(14))
            .textColor(Color.black)
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
        text: Binding<String>
    ) {
        self._text = text
    }
    
    // MARK: - Validation
    
    public func observedObject() -> IOValidatorObservedObject {
        return validationObservedObject
    }
}

struct OTPTextField_Previews: PreviewProvider {
    
    struct OTPTextFieldDemo: View {
    
        @State var otpText: String = "123"
        
        var body: some View {
            OTPTextField(
                text: $otpText
            )
            .padding(20)
            .frame(height: 60)
        }
    }
    
    static var previews: some View {
        OTPTextFieldDemo()
            .previewLayout(.fixed(width: 320, height: 52))
    }
}
