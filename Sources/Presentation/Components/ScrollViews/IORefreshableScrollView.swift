//
//  IORefreshableScrollView.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.10.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public struct IORefreshableScrollView<Content>: View where Content: View {
    
    // MARK: - Constants
    
    private let defaultRefreshThreshold: CGFloat = 32
    private let minRefreshDuration: Double = 4
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates

    private let backgroundColor: Color
    private let content: (_ proxy: ScrollViewProxy) -> Content
    private let pullReleasedFeedbackGenerator: UIImpactFeedbackGenerator
    
    @Binding private var contentSize: CGSize
    @Binding private var isRefreshing: Bool
    @Binding private var scrollOffset: CGFloat
    
    @Namespace private var scrollSpace
    
    @State private var animationStartInterval: Double = 0
    @State private var isAnimatingState = false
    @State private var offset: CGFloat = 0
    
    // MARK: - Properties
    
    public var body: some View {
        IOObservableScrollView(
            contentSize: $contentSize,
            scrollOffset: $scrollOffset
        ) { proxy in
            ZStack(alignment: .top) {
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(backgroundColor)
                            .frame(height: defaultRefreshThreshold)
                        IOActivityIndicatorView(isAnimating: isAnimatingState)
                    }
                    content(proxy)
                }
                .offset(y: isAnimatingState ? 0 : -defaultRefreshThreshold)
            }
        }
        .onChange(of: scrollOffset) { newValue in
            if newValue < (defaultRefreshThreshold * -1.5) {
                withAnimation(
                    Animation
                        .linear(duration: 0.25)
                ) {
                    isAnimatingState = true
                }
                
                animationStartInterval = Date().timeIntervalSince1970
                isRefreshing = true
            }
        }
        .onChange(of: isRefreshing) { newValue in
            if !newValue {
                let currentTimeInterval = Date().timeIntervalSince1970
                let refreshingDuration = currentTimeInterval - animationStartInterval
                let animationDelay: Double
                
                if refreshingDuration > minRefreshDuration {
                    animationDelay = 0
                } else {
                    animationDelay = abs(minRefreshDuration - refreshingDuration)
                }
                
                thread.runOnMainThread(afterMilliSecond: Int(animationDelay * 100)) {
                    withAnimation(
                        Animation
                            .linear(duration: 0.25)
                    ) {
                        isAnimatingState = false
                    }
                }
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        backgroundColor: Color,
        contentSize: Binding<CGSize>,
        isRefreshing: Binding<Bool>,
        scrollOffset: Binding<CGFloat>,
        @ViewBuilder content: @escaping (_ proxy: ScrollViewProxy) -> Content
    ) {
        self.backgroundColor = backgroundColor
        self._contentSize = contentSize
        self._isRefreshing = isRefreshing
        self._scrollOffset = scrollOffset
        self.content = content
        self.pullReleasedFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    }
}

#if DEBUG
struct IORefreshableScrollView_Previews: PreviewProvider {
    
    struct IORefreshableScrollViewDemo: View {
        
        @State private var contentSize: CGSize = .zero
        @State private var isRefreshing = false
        @State private var scrollOffset: CGFloat = 0
        
        var body: some View {
            IORefreshableScrollView(
                backgroundColor: .white,
                contentSize: $contentSize,
                isRefreshing: $isRefreshing,
                scrollOffset: $scrollOffset
            ) { _ in
                VStack {
                    ForEach(IORefreshableScrollViewPreviewData.previewData) { it in
                        Text(it.value)
                    }
                }
            }
        }
    }
     
    static var previews: some View {
        prepare()
        return IORefreshableScrollViewDemo()
    }
}
#endif
