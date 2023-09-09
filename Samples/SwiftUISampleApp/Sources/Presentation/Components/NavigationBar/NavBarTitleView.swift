//
//  NavBarTitleView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

public struct NavBarTitleView: View {
    
    // MARK: - Privates
    
    private let width: CGFloat
    private let height: CGFloat
    private let hasBackButton: Bool
    private let iconName: String
    private let title: String
    private let closeButtonAction: IOClickableHandler?
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            HStack {
                if !iconName.isEmpty {
                    Image(systemName: iconName)
                        .resizable()
                        .frame(width: width, height: height)
                        .padding(.trailing, 4)
                        .padding(.leading, -8)
                }
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
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        iconName: String,
        hasBackButton: Bool,
        width: CGFloat = 16,
        height: CGFloat = 16,
        closeButtonAction: IOClickableHandler? = nil
    ) {
        self.init(
            l.localized,
            iconName: iconName,
            hasBackButton: hasBackButton,
            width: width,
            height: height,
            closeButtonAction: closeButtonAction
        )
    }
    
    public init(
        _ title: String,
        iconName: String,
        hasBackButton: Bool,
        width: CGFloat = 16,
        height: CGFloat = 16,
        closeButtonAction: IOClickableHandler? = nil
    ) {
        self.title = title
        self.iconName = iconName
        self.hasBackButton = hasBackButton
        self.width = width
        self.height = height
        self.closeButtonAction = closeButtonAction
    }
}

#if DEBUG
struct NavBarTitleView_Previews: PreviewProvider {
    
    struct NavBarTitleViewDemo: View {
        
        var body: some View {
            NavBarTitleView(
                "Navigation Bar",
                iconName: "bolt.fill",
                hasBackButton: false
            ) {
                
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return NavBarTitleViewDemo()
    }
}
#endif
