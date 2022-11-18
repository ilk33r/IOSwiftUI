//
//  ChatTextEditorView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

private struct ChatTextEditorViewPreferenceKey: PreferenceKey {
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ChatTextEditorView: View {
    
    @Binding private var text: String
    @State private var hidePlaceholder = false
    @State var textEditorHeight: CGFloat = 38
    
    private var clickHandler: IOClickableHandler?
    private var localizableKey: IOLocalizationType
    
    var body: some View {
        HStack {
            ZStack(alignment: .topLeading) {
                Text(text)
                    .font(type: .regular(12))
                    .foregroundColor(.clear)
                    .padding(8)
                    .background(GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: ChatTextEditorViewPreferenceKey.self,
                                value: geo.frame(in: .local).size.height
                            )
                    })
                TextEditor(text: $text)
                    .font(type: .regular(12))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .frame(height: textEditorHeight, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.colorBorder, lineWidth: 1)
                    )
                    .padding(.top, 8)
                    .padding([.leading, .trailing], 4)
                    .padding(.bottom, 8)
                    .background(
                        IORoundedRect(
                            corners: [.topLeft(0), .topRight(0), .bottomLeft(0), .bottomRight(0)]
                        )
                        .fill(Color.white)
                    )
                Text(type: localizableKey)
                    .font(type: .regular(12))
                    .foregroundColor(.colorPlaceholder)
                    .padding(.top, 24)
                    .padding(.leading, 16)
                    .hidden(isHidden: $hidePlaceholder)
            }
            IOButton(.chatButtonSend)
                .setClick({
                    clickHandler?()
                })
                .font(type: .medium(14))
                .foregroundColor(.black)
                .padding([.top, .bottom], 8)
                .frame(width: 32)
        }
        .padding([.trailing, .leading], 8)
        .onPreferenceChange(ChatTextEditorViewPreferenceKey.self, perform: { newHeight in
            textEditorHeight = max(32, newHeight)
        })
        .onChange(of: text) { newValue in
            if newValue.isEmpty {
                hidePlaceholder = false
            } else {
                hidePlaceholder = true
            }
        }
    }
    
    init(
        _ l: IOLocalizationType,
        text: Binding<String>,
        handler: IOClickableHandler?
    ) {
        self.localizableKey = l
        self._text = text
        self.clickHandler = handler
    }
}

struct ChatTextEditorView_Previews: PreviewProvider {
    
    struct ChatTextEditorViewDemo: View {
        
        @State var text: String = ""
        
        var body: some View {
            ChatTextEditorView(
                .init(rawValue: "Message..."),
                text: $text,
                handler: nil
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ChatTextEditorViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
