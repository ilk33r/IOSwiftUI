//
//  TabBarItemView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import SwiftUI

public struct TabBarItemView: View {
    
    private var icon: Image
    
    public var body: some View {
        icon
            .padding(.top, 9)
    }
    
    public init(
        @ViewBuilder content: () -> Image
    ) {
        self.icon = content()
    }
}

struct TabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItemView(
            content: {
            Image.icnTabBarHome
        })
        .previewLayout(.sizeThatFits)
    }
}
