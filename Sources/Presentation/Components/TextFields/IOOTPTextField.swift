//
//  IOOTPTextField.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import SwiftUI

public struct IOOTPTextField<TextFieldOverlay: View>: View {
    
    // MARK: - Privates
    
    @Binding private var text: String
    
    private let maxLength: Int
    private let overlayWidth: CGFloat
    private let textFieldOverlay: () -> TextFieldOverlay
    private let fontType: IOFontType
    private let textColor: Color
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                TextField("", text: $text) { isEditing in
                    if isEditing {
                        text = ""
                    }
                }
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .disableAutocorrection(true)
                .accentColor(.clear)
                .foregroundColor(.clear)
                .padding()
                .overlay(overlayView(proxy: proxy))
                .zIndex(1)
                
                textsView(proxy: proxy)
                    .zIndex(2)
            }
            .onChange(of: text) { newValue in
                text = newValue.substring(maxLenth: maxLength)
            }
        }
    }
    
    private func overlayView(proxy: GeometryProxy) -> some View {
        let maxLengthFloat = CGFloat(maxLength)
        let overlayAllWidth = maxLengthFloat * overlayWidth
        let overlaySpace = (proxy.size.width - overlayAllWidth) / (maxLengthFloat - 1)
        
        return HStack(spacing: overlaySpace) {
            ForEach(0..<maxLength, id: \.self) { _ in
                textFieldOverlay()
            }
        }
        .frame(width: proxy.size.width)
    }
    
    private func textsView(proxy: GeometryProxy) -> some View {
        let maxLengthFloat = CGFloat(maxLength)
        let overlayAllWidth = maxLengthFloat * overlayWidth
        let overlaySpace = (proxy.size.width - overlayAllWidth) / (maxLengthFloat - 1)
        
        return HStack(spacing: overlaySpace) {
            ForEach(0..<text.count, id: \.self) { index in
                Text(text.substring(start: index, count: 1))
                    .font(type: fontType)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.center)
                    .frame(width: overlayWidth)
            }
        }
        .frame(width: proxy.size.width, alignment: .leading)
    }
    
    // MARK: - Initialization Methods
    
    public init(
        text: Binding<String>,
        maxLength: Int,
        overlayWidth: CGFloat,
        @ViewBuilder textFieldOverlay: @escaping () -> TextFieldOverlay
    ) {
        self._text = text
        self.maxLength = maxLength
        self.overlayWidth = overlayWidth
        self.textFieldOverlay = textFieldOverlay
        self.fontType = .systemRegular(16)
        self.textColor = Color.black
    }
    
    private init(
        text: Binding<String>,
        maxLength: Int,
        overlayWidth: CGFloat,
        @ViewBuilder textFieldOverlay: @escaping () -> TextFieldOverlay,
        fontType: IOFontType,
        textColor: Color
    ) {
        self._text = text
        self.maxLength = maxLength
        self.overlayWidth = overlayWidth
        self.textFieldOverlay = textFieldOverlay
        self.fontType = fontType
        self.textColor = textColor
    }
    
    // MARK: - Modifiers
    
    public func font(type: IOFontType) -> IOOTPTextField<TextFieldOverlay> {
        return IOOTPTextField(
            text: $text,
            maxLength: maxLength,
            overlayWidth: overlayWidth,
            textFieldOverlay: textFieldOverlay,
            fontType: type,
            textColor: textColor
        )
    }
    
    public func textColor(_ color: Color) -> IOOTPTextField<TextFieldOverlay> {
        return IOOTPTextField(
            text: $text,
            maxLength: maxLength,
            overlayWidth: overlayWidth,
            textFieldOverlay: textFieldOverlay,
            fontType: fontType,
            textColor: color
        )
    }
}

struct IOOTPTextField_Previews: PreviewProvider {
    
    struct IOOTPTextFieldDemo: View {
    
        @State var otpText: String = "123"
        
        var body: some View {
            IOOTPTextField(
                text: $otpText,
                maxLength: 6,
                overlayWidth: 46,
                textFieldOverlay: {
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(width: 46, height: 52)
                }
            )
            .padding(20)
            .frame(height: 60)
        }
    }
    
    static var previews: some View {
        IOOTPTextFieldDemo()
            .previewLayout(.fixed(width: 320, height: 52))
    }
}
