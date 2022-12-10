//
//  NavBarTitleView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure

public struct NavBarTitleView: View {
    
    private let width: CGFloat
    private let height: CGFloat
    
    private var iconName: String
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: width, height: height)
                .padding(.trailing, 4)
                .padding(.leading, -8)
            Text(type: localizationType)
                .font(type: .medium(17))
        }
    }
    
    public init(
        _ l: IOLocalizationType,
        iconName: String,
        width: CGFloat = 16,
        height: CGFloat = 16
    ) {
        self.localizationType = l
        self.iconName = iconName
        self.width = width
        self.height = height
    }
}

#if DEBUG
struct NavBarTitleView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return NavBarTitleView(.init(rawValue: "Navigation Bar"), iconName: "bolt.fill")
            .previewLayout(.sizeThatFits)
    }
}
#endif
