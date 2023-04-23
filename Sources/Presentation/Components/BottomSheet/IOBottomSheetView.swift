// 
//  IOBottomSheetView.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

struct IOBottomSheetViewSizePreferenceKey: PreferenceKey {
    
    static var defaultValue = CGSize.zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        defaultValue = value
    }
}

public struct IOBottomSheetView<Content: View>: IOBottomSheetContentView {
    
    // MARK: - Publics
    
    public var animationDuration: Double { 0.25 }
    public var data: IOBottomSheetContentViewData! = IOBottomSheetContentViewData()
    
    // MARK: - Privates
    
    private let backgroundColor: Color
    private let contentView: () -> Content
    private let cornerRadius: CGFloat
    private let paddingTop: CGFloat
    private let shadowColor: Color
    private let shadowRadius: CGFloat
    
    @State private var bottomSheetPresenter: IOBottomSheetPresenter! = nil
    @State private var contentSize: CGSize = .zero
    @State private var initialOffset: CGFloat = 0
    @State private var offsetY: CGFloat = 2000
    @Namespace private var sheetSpace
    
    // MARK: - Body
    
    @ViewBuilder
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                ZStack {
                    contentView()
                        .padding(.top, paddingTop)
                        .padding(.bottom, proxy.safeAreaInsets.bottom)
                        .background(GeometryReader { geo in
                            let contentSize = geo.frame(in: .named(sheetSpace)).size
                            Color.clear
                                .preference(
                                    key: IOBottomSheetViewSizePreferenceKey.self,
                                    value: contentSize
                                )
                        })
                }
                .coordinateSpace(name: sheetSpace)
                .onPreferenceChange(IOBottomSheetViewSizePreferenceKey.self) { value in
                    contentSize = value
                    initialOffset = proxy.size.height - contentSize.height + paddingTop + (proxy.safeAreaInsets.bottom * 2)
                    
                    withAnimation(
                        Animation
                            .easeOut(duration: animationDuration)
                            .delay(0.1)
                    ) {
                        offsetY = initialOffset
                    }
                }
                .frame(width: proxy.size.width, height: contentSize.height, alignment: .bottom)
                .background(
                    IORoundedRect(
                        corners: [
                            .topLeft(cornerRadius),
                            .topRight(cornerRadius),
                            .bottomLeft(0),
                            .bottomRight(0)
                        ]
                    )
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: -1)
                )
                .offset(y: offsetY)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let newOffset = gesture.translation.height
                            if newOffset < 0 {
                                return
                            }
                            
                            offsetY = initialOffset + newOffset
                        }
                        .onEnded { gesture in
                            let locationDiff = gesture.location.y - gesture.startLocation.y
                            if locationDiff > initialOffset * 0.20 {
                                withAnimation(
                                    Animation
                                        .easeOut(duration: animationDuration)
                                ) {
                                    offsetY = 2000
                                }
                                
                                data.presenter?.dismiss()
                            } else {
                                withAnimation(
                                    Animation
                                        .easeOut(duration: 0.15)
                                ) {
                                    offsetY = initialOffset
                                }
                            }
                        }
                )
            }
            .ignoresSafeArea()
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        backgroundColor: Color = Color.white,
        cornerRadius: CGFloat = 24,
        paddingTop: CGFloat = 32,
        shadowColor: Color = Color(white: 0, opacity: 0.3),
        shadowRadius: CGFloat = 6,
        @ViewBuilder _ contentView: @escaping () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.paddingTop = paddingTop
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.contentView = contentView
    }
}

#if DEBUG
struct IOBottomSheetView_Previews: PreviewProvider {
    
    struct IOBottomSheetViewDemo: View {
        
        var body: some View {
            IOBottomSheetView {
                VStack {
                    Image(systemName: "lanyardcard")
                        .resizable()
                        .frame(width: 36, height: 50)
                    Text("type: .registerNfcInfo0")
                        .font(type: .systemRegular(14))
                        .lineLimit(0)
                        .padding(.top, 8)
                    Text("type: .registerNfcInfo1")
                        .font(type: .systemRegular(14))
                        .lineLimit(0)
                        .padding(.top, 8)
                }
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return IOBottomSheetViewDemo()
    }
}
#endif
