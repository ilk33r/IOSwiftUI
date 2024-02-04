// 
//  CartButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.02.2024.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIPresentation
import SwiftUI

public struct CartButton: View, IOClickable {
    
    // MARK: - Privates
    
    public var handler: IOClickableHandler?
    
    // MARK: - Body
    
    public var body: some View {
        IOButton {
            ZStack {
                HStack {
                    Image(systemName: "cart")
                        .foregroundColor(.black)
                    Text(type: .commonAddToCart)
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing], 4)
                        .font(type: .systemSemibold(16))
                        .foregroundColor(.black)
                }
            }
        }
        .setClick(handler)
    }
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    private init(handler: IOClickableHandler?) {
        self.handler = handler
    }
    
    // MARK: - Clickable
    
    public func setClick(_ handler: IOClickableHandler?) -> CartButton {
        Self(handler: handler)
    }
}

#if DEBUG
struct CartButton_Previews: PreviewProvider {
    
    struct CartButtonDemo: View {
        
        var body: some View {
            CartButton()
        }
    }
    
    static var previews: some View {
        prepare()
        return CartButtonDemo()
    }
}
#endif
