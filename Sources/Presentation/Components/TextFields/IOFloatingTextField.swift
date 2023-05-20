//
//  IOFloatingTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 23.08.2022.
//

import IOSwiftUIInfrastructure
import SwiftUI

public struct IOFloatingTextField<TextFieldOverlay: View>: View {
    
    // MARK: - Privates
    
    private let title: String
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
    
    @Binding private var isEditingBinder: Bool
    @Binding private var text: String
    
    @State private var isEditing = false
    
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
            TextField("", text: $text) { isEditing in
                self.isEditing = isEditing
                isEditingBinder = isEditing
            }
            .keyboardType(keyboardType)
            .disableAutocorrection(disableAutocorrection)
            .autocapitalization(capitalization)
            .padding()
            .overlay(textFieldOverlay)
            .foregroundColor(foregroundColor)
            .accentColor(placeholderColor)
            .font(type: fontType)
            .zIndex(1)
            Text(title)
                .font(type: fontType)
                .foregroundColor(placeholderColor)
                .background(backgroundColor)
                .allowsHitTesting(false)
                .zIndex(2)
                .padding(placeholderPadding)
                .animation(.linear(duration: 0.15), value: isEditing)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        @ViewBuilder textFieldOverlay: () -> TextFieldOverlay
    ) {
        self.init(
            l.localized,
            text: text,
            keyboardType: keyboardType,
            textFieldOverlay: textFieldOverlay
        )
    }
    
    public init(
        _ title: String,
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
        self.title = title
        self.placeholderColor = Color.gray
        self.placeholderPaddingActive = EdgeInsets(top: 0, leading: 12, bottom: 52, trailing: 0)
        self.placeholderPaddingDefault = EdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 0)
        self.textFieldOverlay = textFieldOverlay()
        self.disableAutocorrection = false
        self.capitalization = .words
    }
    
    private init(
        _ title: String,
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
        self.title = title
        self.placeholderColor = placeholderColor
        self.placeholderPaddingActive = placeholderPaddingActive
        self.placeholderPaddingDefault = placeholderPaddingDefault
        self.textFieldOverlay = textFieldOverlay
        self.disableAutocorrection = disableAutocorrection
        self.capitalization = capitalization
    }
}

public extension IOFloatingTextField {
    
    // MARK: - Modifiers
    
    func activePlaceholderPadding(_ padding: EdgeInsets) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func backgroundColor(_ color: Color) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func capitalization(_ type: UITextAutocapitalizationType) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func disableCorrection(_ correction: Bool) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func editingHandler(
        isEditing: Binding<Bool>
    ) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func font(type: IOFontType) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func textColor(_ color: Color) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func placeholderColor(_ color: Color) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
    
    func placeholderPadding(_ padding: EdgeInsets) -> IOFloatingTextField<TextFieldOverlay> {
        Self(
            title,
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
struct IOFloatingTextField_Previews: PreviewProvider {
    
    struct FloatingTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOFloatingTextField(
                "Email address",
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
