//
//  IndicatorView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI

public struct IndicatorView: View {
    
    // MARK: - Body
    
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
    
    // MARK: - Initialization Methods
    
    public init() {
        
    }
}

#if DEBUG
struct IndicatorView_Previews: PreviewProvider {
    
    struct IndicatorViewDemo: View {
        
        var body: some View {
            IndicatorView()
        }
    }
    
    static var previews: some View {
        prepare()
        return IndicatorViewDemo()
    }
}
#endif
