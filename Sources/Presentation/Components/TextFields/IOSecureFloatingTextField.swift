//
//  IOSecureFloatingTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.09.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOSecureFloatingTextField<TextFieldOverlay: View>: View {
    
    // MARK: - Privates
    
    @Binding private var isEditingBinder: Bool
    @Binding private var text: String
    @State private var isEditing = false
    
    private let localizationType: IOLocalizationType
    private let backgroundColor: Color
    private let capitalization: UITextAutocapitalizationType
    private let disableAutocorrection: Bool
    private let fontType: IOFontType
    private let foregroundColor: Color
    private let keyboardType: UIKeyboardType
    private let placeholderColor: Color
    private let placeholderPaddingActive: EdgeInsets
    private let placeholderPaddingDefault: EdgeInsets
    private let textFieldOverlay: TextFieldOverlay
    
    private var placeholderPadding: EdgeInsets {
        if shouldPlaceHolderMove {
            return placeholderPaddingActive
        }
        
        return placeholderPaddingDefault
    }
    
    private var shouldPlaceHolderMove: Bool {
        isEditing || !text.isEmpty
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack(alignment: .leading) {
            SecureField("", text: $text)
            .keyboardType(keyboardType)
            .disableAutocorrection(disableAutocorrection)
            .autocapitalization(capitalization)
            .padding()
            .overlay(textFieldOverlay)
            .foregroundColor(foregroundColor)
            .accentColor(placeholderColor)
            .zIndex(1)
            Text(localizationType.localized)
                .font(type: fontType)
                .foregroundColor(placeholderColor)
                .background(backgroundColor)
                .allowsHitTesting(false)
                .zIndex(2)
                .padding(placeholderPadding)
                .animation(.linear(duration: 0.15), value: isEditing)
        }
        .onChange(of: text) { newValue in
            if newValue.isEmpty {
                isEditing = false
                isEditingBinder = false
            } else {
                isEditing = true
                isEditingBinder = true
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        @ViewBuilder textFieldOverlay: () -> TextFieldOverlay
    ) {
        self._text = text
        self._isEditingBinder = Binding.constant(false)
        self.backgroundColor = Color.white
        self.fontType = .systemRegular(16)
        self.foregroundColor = Color.black
        self.keyboardType = keyboardType
        self.localizationType = l
        self.placeholderColor = Color.gray
        self.placeholderPaddingActive = EdgeInsets(top: 0, leading: 12, bottom: 52, trailing: 0)
        self.placeholderPaddingDefault = EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0)
        self.textFieldOverlay = textFieldOverlay()
        self.disableAutocorrection = false
        self.capitalization = .words
    }
    
    private init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        backgroundColor: Color,
        fontType: IOFontType,
        foregroundColor: Color,
        keyboardType: UIKeyboardType,
        editingBinder: Binding<Bool>,
        placeholderColor: Color,
        placeholderPaddingActive: EdgeInsets,
        placeholderPaddingDefault: EdgeInsets,
        textFieldOverlay: TextFieldOverlay,
        disableAutocorrection: Bool,
        capitalization: UITextAutocapitalizationType
    ) {
        self._text = text
        self._isEditingBinder = editingBinder
        self.backgroundColor = backgroundColor
        self.fontType = fontType
        self.foregroundColor = foregroundColor
        self.keyboardType = keyboardType
        self.localizationType = l
        self.placeholderColor = placeholderColor
        self.placeholderPaddingActive = placeholderPaddingActive
        self.placeholderPaddingDefault = placeholderPaddingDefault
        self.textFieldOverlay = textFieldOverlay
        self.disableAutocorrection = disableAutocorrection
        self.capitalization = capitalization
    }
    
    // MARK: - Modifiers
    
    public func activePlaceholderPadding(_ padding: EdgeInsets) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: fontType,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: padding,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func backgroundColor(_ color: Color) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: color,
            fontType: fontType,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func capitalization(_ type: UITextAutocapitalizationType) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: fontType,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: type
        )
    }
    
    public func disableCorrection(_ correction: Bool) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: fontType,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: correction,
            capitalization: capitalization
        )
    }
    
    public func editingHandler(
        isEditing: Binding<Bool>
    ) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: fontType,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: isEditing,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func font(type: IOFontType) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: type,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func textColor(_ color: Color) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: fontType,
            foregroundColor: color,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func placeholderColor(_ color: Color) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: fontType,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: color,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: placeholderPaddingDefault,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
    
    public func placeholderPadding(_ padding: EdgeInsets) -> IOSecureFloatingTextField<TextFieldOverlay> {
        Self(
            localizationType,
            text: $text,
            backgroundColor: backgroundColor,
            fontType: fontType,
            foregroundColor: foregroundColor,
            keyboardType: keyboardType,
            editingBinder: $isEditingBinder,
            placeholderColor: placeholderColor,
            placeholderPaddingActive: placeholderPaddingActive,
            placeholderPaddingDefault: padding,
            textFieldOverlay: textFieldOverlay,
            disableAutocorrection: disableAutocorrection,
            capitalization: capitalization
        )
    }
}

#if DEBUG
struct IOSecureFloatingTextField_Previews: PreviewProvider {
    
    struct FloatingTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOSecureFloatingTextField(
                .init(rawValue: "Email address"),
                text: $emailAddress,
                textFieldOverlay: {
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(height: 52)
                }
            )
            .padding(20)
            .frame(height: 60)
        }
    }
    
    static var previews: some View {
        prepare()
        return FloatingTextFieldDemo()
    }
}
#endif
