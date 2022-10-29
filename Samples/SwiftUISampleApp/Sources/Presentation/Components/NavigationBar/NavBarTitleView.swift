//
//  NavBarTitleView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure

public struct NavBarTitleView: View {
    
    private var iconName: String
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 16, height: 16)
                .padding(.trailing, 4)
                .padding(.leading, -8)
            Text(type: localizationType)
                .font(type: .systemSemibold(17))
        }
    }
    
    public init(_ l: IOLocalizationType, iconName: String) {
        self.localizationType = l
        self.iconName = iconName
    }
}

struct NavBarTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarTitleView(.init(rawValue: "Navigation Bar"), iconName: "bolt.fill")
            .previewLayout(.sizeThatFits)
    }
}
