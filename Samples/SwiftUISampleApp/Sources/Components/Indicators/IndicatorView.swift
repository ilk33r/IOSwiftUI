//
//  IndicatorView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import SwiftUI
import IOSwiftUIComponents

public struct IndicatorView: View {
    
    public var body: some View {
        ZStack {
            Color.colorPassthrought
            Color.white
                .frame(width: 120, height: 120)
                .cornerRadius(12)
                .shadow(
                    color: .colorPlaceholder,
                    radius: 10,
                    x: 0,
                    y: 2
                )
            IOIndicatorView()
                .backgroundColor(.colorPlaceholder)
                .circleColor(.black)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    public init() {
        
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView()
    }
}
