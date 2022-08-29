//
//  IOObservableScrollView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI

struct IOScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

public struct IOObservableScrollView<Content>: View where Content: View {
    
    private let content: (ScrollViewProxy) -> Content
    
    @Binding private var scrollOffset: CGFloat
    @Namespace private var scrollSpace
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        Color.clear
                            .preference(
                                key: IOScrollViewOffsetPreferenceKey.self,
                                value: offset
                            )
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(IOScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
    
    public init(
        scrollOffset: Binding<CGFloat>,
        @ViewBuilder content: @escaping (ScrollViewProxy) -> Content
    ) {
        self._scrollOffset = scrollOffset
        self.content = content
    }
}
