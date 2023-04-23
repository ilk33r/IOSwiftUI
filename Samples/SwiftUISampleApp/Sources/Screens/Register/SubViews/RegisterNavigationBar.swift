// 
//  RegisterNavigationBar.swift
//  
//
//  Created by Adnan ilker Ozcan on 23.04.2023.
//

import Foundation
import IOSwiftUICommon
import SwiftUI

struct RegisterNavigationBar: View {
    
    // MARK: - Privates
    
    private let proxy: GeometryProxy
    private var clickHandler: IOClickableHandler?
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 4)
                    .padding(.leading, -8)
                Text(type: .titleProfile)
                    .font(type: .medium(17))
                    .multilineTextAlignment(.center)
            }
            .padding(.leading, 32)
            .padding(.trailing, 32)
            .frame(width: proxy.size.width - 108)
            Button {
                clickHandler?()
            } label: {
                Image(systemName: "wave.3.right")
            }
            .foregroundColor(.black)
            .frame(width: 32)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        proxy: GeometryProxy,
        handler: IOClickableHandler?
    ) {
        self.proxy = proxy
        self.clickHandler = handler
    }
}

#if DEBUG
struct RegisterNavigationBar_Previews: PreviewProvider {
    
    struct RegisterNavigationBarDemo: View {
        
        var body: some View {
            GeometryReader { proxy in
                RegisterNavigationBar(
                    proxy: proxy
                ) {
                }
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return RegisterNavigationBarDemo()
    }
}
#endif
