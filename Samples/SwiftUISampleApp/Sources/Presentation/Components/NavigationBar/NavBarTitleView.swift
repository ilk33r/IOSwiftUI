//
//  NavBarTitleView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIInfrastructure
import SwiftUI

public struct NavBarTitleView: View {
    
    // MARK: - Privates
    
    private let width: CGFloat
    private let height: CGFloat
    private let iconName: String
    private let title: String
    
    // MARK: - Body
    
    public var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: width, height: height)
                .padding(.trailing, 4)
                .padding(.leading, -8)
            Text(title)
                .font(type: .medium(17))
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ l: IOLocalizationType,
        iconName: String,
        width: CGFloat = 16,
        height: CGFloat = 16
    ) {
        self.init(
            l.localized,
            iconName: iconName,
            width: width,
            height: height
        )
    }
    
    public init(
        _ title: String,
        iconName: String,
        width: CGFloat = 16,
        height: CGFloat = 16
    ) {
        self.title = title
        self.iconName = iconName
        self.width = width
        self.height = height
    }
}

#if DEBUG
struct NavBarTitleView_Previews: PreviewProvider {
    
    struct NavBarTitleViewDemo: View {
        
        var body: some View {
            NavBarTitleView("Navigation Bar", iconName: "bolt.fill")
        }
    }
    
    static var previews: some View {
        prepare()
        return NavBarTitleViewDemo()
    }
}
#endif
