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

public struct IOObservableScrollView<Content>: View where Content: View {
    
    private let content: (_ proxy: ScrollViewProxy) -> Content
    
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
                                key: IOSizePreferenceKey.self,
                                value: contentSize
                            )
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(IOScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
        .onPreferenceChange(IOSizePreferenceKey.self) { value in
            contentSize = value
        }
    }
    
    public init(
        contentSize: Binding<CGSize>,
        scrollOffset: Binding<CGFloat>,
        @ViewBuilder content: @escaping (_ proxy: ScrollViewProxy) -> Content
    ) {
        self._contentSize = contentSize
        self._scrollOffset = scrollOffset
        self.content = content
    }
}
