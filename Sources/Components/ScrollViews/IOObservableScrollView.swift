//
//  IOObservableScrollView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIInfrastructure
import SwiftUI

struct IOScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct IOScrollViewSizePreferenceKey: PreferenceKey {
    
    static var defaultValue = CGSize.zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        defaultValue = value
    }
}

public struct IOObservableScrollView<Content>: View where Content: View {
    
    private let content: (ScrollViewProxy) -> Content
    
    @Binding private var contentSize: CGSize
    @Binding private var scrollOffset: CGFloat
    @Namespace private var scrollSpace
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        let contentSize = geo.frame(in: .named(scrollSpace)).size
                        Color.clear
                            .preference(
                                key: IOScrollViewOffsetPreferenceKey.self,
                                value: offset
                            )
                            .preference(
                                key: IOScrollViewSizePreferenceKey.self,
                                value: contentSize
                            )
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(IOScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
        .onPreferenceChange(IOScrollViewSizePreferenceKey.self) { value in
            contentSize = value
        }
    }
    
    public init(
        contentSize: Binding<CGSize>,
        scrollOffset: Binding<CGFloat>,
        @ViewBuilder content: @escaping (ScrollViewProxy) -> Content
    ) {
        self._contentSize = contentSize
        self._scrollOffset = scrollOffset
        self.content = content
    }
}
