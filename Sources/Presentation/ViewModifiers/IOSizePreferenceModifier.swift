//
//  IOSizePreferenceModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.02.2023.
//

import Foundation
import SwiftUI

public struct IOSizePreferenceKey: PreferenceKey {
    
    public static var defaultValue = CGSize.zero
    
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let nextValue = nextValue()
        value = CGSize(width: value.width + nextValue.width, height: value.height + nextValue.height)
    }
}

public extension View {
    
    @ViewBuilder
    func sizePreference() -> some View {
        modifier(IOSizePreferenceModifier())
    }
}

struct IOSizePreferenceModifier: ViewModifier {
    
    init() {
    }
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geo in
                Color.clear
                    .preference(
                        key: IOSizePreferenceKey.self,
                        value: geo.frame(in: .global).size
                    )
            })
    }
}
