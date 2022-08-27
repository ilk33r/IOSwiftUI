//
//  TabBarItemCenterViews.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import SwiftUI

public struct TabBarItemCenterViews: View {
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            .colorTabStart,
                            .colorTabEnd
                        ],
                        startPoint: UnitPoint(x: 0, y: 0),
                        endPoint: UnitPoint(x: 0, y: 1)
                    )
                )
                .frame(width: 70, height: 40)
            Image.icnPlus
        }
    }
    
    public init() {
    }
}

struct TabBarItemCenterViews_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItemCenterViews()
            .previewLayout(.sizeThatFits)
    }
}
