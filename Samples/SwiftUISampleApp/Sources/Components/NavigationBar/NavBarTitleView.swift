//
//  NavBarTitleView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI
import IOSwiftUIInfrastructure

public struct NavBarTitleView: View {
    
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        Text(type: localizationType)
            .font(type: .systemSemibold(17))
    }
    
    public init(_ l: IOLocalizationType) {
        self.localizationType = l
    }
}

struct NavBarTitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarTitleView(.init(rawValue: "Navigation Bar"))
            .previewLayout(.sizeThatFits)
    }
}
