//
//  SearchNavBar.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import SwiftUI

struct SearchNavBar: View {
    
    // MARK: - Defs
    
    typealias EditingEndHandler = () -> Void
    
    // MARK: - Privates
    
    private let editingEndHandler: EditingEndHandler?
    
    @Binding private var text: String
    
    @State private var isEditing = false
    
    private var isPlaceholderHidden: Bool {
        isEditing || !text.isEmpty
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                TextField("", text: $text) { isEditing in
                    self.isEditing = isEditing
                    
                    if !isEditing {
                        editingEndHandler?()
                    }
                }
                .font(type: .regular(14))
                .keyboardType(.webSearch)
                .foregroundColor(Color.black)
                .accentColor(Color.colorPlaceholder)
                .background(Color.white)
                .padding(.leading, 32)
                .padding(.vertical)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.colorPlaceholder, lineWidth: 2)
                        .frame(width: proxy.size.width - 4, height: proxy.size.height - 4)
                )
                
                if !isPlaceholderHidden {
                    Text(type: .searchInputPlaceholder)
                        .font(type: .thin(14))
                        .foregroundColor(Color.colorPlaceholder)
                        .allowsHitTesting(false)
                        .frame(height: proxy.size.height, alignment: .leading)
                        .padding(.top, 2)
                        .padding(.leading, 34)
                }
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundColor(Color.colorPlaceholder)
                    .frame(width: 20, height: 20, alignment: .leading)
                    .padding(.top, (proxy.size.height / 2) - 8)
                    .padding(.leading, 8)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        text: Binding<String>,
        editingEndHandler: EditingEndHandler?
    ) {
        self._text = text
        self.editingEndHandler = editingEndHandler
    }
}

struct SearchNavBar_Previews: PreviewProvider {
    
    struct SearchNavBarDemo: View {
        
        @State private var text = ""
        
        var body: some View {
            SearchNavBar(
                text: $text,
                editingEndHandler: {
                    
                }
            )
            .frame(width: 320, height: 44)
        }
    }
    
    static var previews: some View {
        prepare()
        return SearchNavBarDemo()
            .previewLayout(.fixed(width: 320, height: 44))
    }
}
