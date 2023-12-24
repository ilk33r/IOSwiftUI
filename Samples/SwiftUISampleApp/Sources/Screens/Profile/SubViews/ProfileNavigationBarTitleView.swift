// 
//  ProfileNavigationBarTitleView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2023.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

struct ProfileNavigationBarTitleView: View {
    
    // MARK: - Privates
    
    private let hasBackButton: Bool
    private let title: String
    private let cartButtonAction: IOClickableHandler?
    private let closeButtonAction: IOClickableHandler?
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            HStack {
                Text(title)
                    .font(type: .medium(17))
            }
            .padding(.trailing, hasBackButton ? 55 : 0)
            
            if closeButtonAction != nil {
                ZStack {
                    Button {
                        closeButtonAction?()
                    } label: {
                        Image(systemName: "xmark")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.black)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 18, height: 18)
                    }
                    .frame(
                        width: 40,
                        height: 40
                    )
                    .padding(.trailing, 8)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            if cartButtonAction != nil {
                ZStack {
                    Button {
                        cartButtonAction?()
                    } label: {
                        Image(systemName: "cart")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.black)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 18, height: 18)
                    }
                    .frame(
                        width: 40,
                        height: 40
                    )
                    .padding(.trailing, 8)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Initialization Methods
    
    init(
        _ l: IOLocalizationType,
        hasBackButton: Bool,
        closeButtonAction: IOClickableHandler?,
        cartButtonAction: IOClickableHandler?
    ) {
        self.init(
            l.localized,
            hasBackButton: hasBackButton,
            closeButtonAction: closeButtonAction,
            cartButtonAction: cartButtonAction
        )
    }
    
    init(
        _ title: String,
        hasBackButton: Bool,
        closeButtonAction: IOClickableHandler?,
        cartButtonAction: IOClickableHandler?
    ) {
        self.title = title
        self.hasBackButton = hasBackButton
        self.closeButtonAction = closeButtonAction
        self.cartButtonAction = cartButtonAction
    }
}

#if DEBUG
struct ProfileNavigationBarTitleView_Previews: PreviewProvider {
    
    struct ProfileNavigationBarTitleViewDemo: View {
        
        var body: some View {
            ProfileNavigationBarTitleView(
                "Navigation Bar",
                hasBackButton: false
            ) {
                
            } cartButtonAction: {
                
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return ProfileNavigationBarTitleViewDemo()
    }
}
#endif
