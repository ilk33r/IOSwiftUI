//
//  SwiftUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppResources

public struct FloatingTextField: View {
    
    @Binding var text: String
    @State private var isEditing = false
    @FocusState private var isInputActive: Bool
    
    private var keyboardType: UIKeyboardType
    private var localizationType: IOLocalizationType
    
    private var placeholderPadding: EdgeInsets {
        if self.shouldPlaceHolderMove {
            return EdgeInsets(top: 0, leading:12, bottom: 52, trailing: 0)
        }
        
        return EdgeInsets(top: 0, leading:17, bottom: 0, trailing: 0)
    }
    
    private var shouldPlaceHolderMove: Bool {
        self.isEditing || (self.text.count != 0)
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: self.$text) { isEditing in
                self.isEditing = isEditing
            }
            .keyboardType(self.keyboardType)
            .focused($isInputActive)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(IOLocalizationType.commonDone.localized) {
                        self.isInputActive = false
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(height: 52)
            )
            .foregroundColor(Color.black)
            .accentColor(Color.colorPlaceholder)
            Text(self.localizationType.localized)
                .font(type: .regular(15))
                .foregroundColor(.colorPlaceholder)
                .background(Color.white)
                .allowsHitTesting(false)
                .padding(self.placeholderPadding)
                .animation(.linear(duration: 0.15), value: self.isEditing)
        }
    }
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default
    ) {
        self.keyboardType = keyboardType
        self.localizationType = l
        self._text = text
        IOFontTypes.registerFontsIfNecessary(Bundle.resources)
    }
    
    public func keyboardType(_ type: UIKeyboardType) -> FloatingTextField {
        return FloatingTextField(
            self.localizationType,
            text: self.$text,
            keyboardType: type
        )
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    
    struct FloatingTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            FloatingTextField(.init(rawValue: "Email address"), text: self.$emailAddress)
                .padding(20)
        }
    }
    
    static var previews: some View {
        FloatingTextFieldDemo()
    }
}
