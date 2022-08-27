//
//  IOFloatingTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 23.08.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

public struct IOFloatingTextField<TextFieldOverlay: View>: View {
    
    @Binding private var isEditingBinder: Bool
    @Binding private var text: String
    @State private var isEditing = false
    
    private var backgroundColor: Color
    private var fontType: IOFontType
    private var foregroundColor: Color
    private var keyboardType: UIKeyboardType
    private var localizationType: IOLocalizationType
    private var placeholderColor: Color
    private var placeholderPaddingActive: EdgeInsets
    private var placeholderPaddingDefault: EdgeInsets
    private var textFieldOverlay: TextFieldOverlay
    
    private var placeholderPadding: EdgeInsets {
        if shouldPlaceHolderMove {
            return placeholderPaddingActive
        }
        
        return placeholderPaddingDefault
    }
    
    private var shouldPlaceHolderMove: Bool {
        isEditing || !text.isEmpty
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text) { isEditing in
                self.isEditing = isEditing
                self.isEditingBinder = isEditing
            }
            .keyboardType(keyboardType)
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
    }
    
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
        textFieldOverlay: TextFieldOverlay
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
    }
    
    public func activePlaceholderPadding(_ padding: EdgeInsets) -> IOFloatingTextField<TextFieldOverlay> {
        return IOFloatingTextField(
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
            textFieldOverlay: textFieldOverlay
        )
    }
    
    public func backgroundColor(_ color: Color) -> IOFloatingTextField<TextFieldOverlay> {
        return IOFloatingTextField(
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
            textFieldOverlay: textFieldOverlay
        )
    }
    
    public func editingHandler(
        isEditing: Binding<Bool>
    ) -> IOFloatingTextField<TextFieldOverlay> {
        return IOFloatingTextField(
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
            textFieldOverlay: textFieldOverlay
        )
    }
    
    public func font(type: IOFontType) -> IOFloatingTextField<TextFieldOverlay> {
        return IOFloatingTextField(
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
            textFieldOverlay: textFieldOverlay
        )
    }
    
    public func textColor(_ color: Color) -> IOFloatingTextField<TextFieldOverlay> {
        return IOFloatingTextField(
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
            textFieldOverlay: textFieldOverlay
        )
    }
    
    public func placeholderColor(_ color: Color) -> IOFloatingTextField<TextFieldOverlay> {
        return IOFloatingTextField(
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
            textFieldOverlay: textFieldOverlay
        )
    }
    
    public func placeholderPadding(_ padding: EdgeInsets) -> IOFloatingTextField<TextFieldOverlay> {
        return IOFloatingTextField(
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
            textFieldOverlay: textFieldOverlay
        )
    }
}

struct IOFloatingTextField_Previews: PreviewProvider {
    
    struct FloatingTextFieldDemo: View {
    
        @State var emailAddress: String = ""
        
        var body: some View {
            IOFloatingTextField(
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
        FloatingTextFieldDemo()
    }
}