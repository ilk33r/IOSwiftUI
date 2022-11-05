//
//  SettingMenuItemView.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import IOSwiftUICommon
import SwiftUI
import SwiftUISampleAppPresentation

struct SettingMenuItemView: View {
    
    // MARK: - Privates
    
    private let clickHandler: IOClickableHandler?
    private let menuItem: SettingsMenuItemUIModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: menuItem.iconName)
                    .allowsHitTesting(false)
                Text(type: menuItem.localizableKey)
                    .allowsHitTesting(false)
                    .font(type: .regular(14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .padding(.leading, 4)
            }
            .padding(.vertical, 12)
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(.white)
                .setClick {
                    clickHandler?()
                }
        )
    }
    
    init(
        menuItem: SettingsMenuItemUIModel,
        handler: IOClickableHandler?
    ) {
        self.menuItem = menuItem
        self.clickHandler = handler
    }
}

struct SettingMenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingMenuItemView(
            menuItem: SettingsMenuItemUIModel(iconName: "person.fill", localizableKey: .settingsMenuUpdateProfile),
            handler: {
            }
        )
        .previewLayout(.sizeThatFits)
    }
}
