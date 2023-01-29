// 
//  IOToastView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.01.2023.
//

import Foundation
import SwiftUI

public struct IOToastView: View {
    
    // MARK: - Defs
    
    struct HeightPreferenceKey: PreferenceKey {
        
        static var defaultValue = CGFloat.zero
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            defaultValue = value
        }
    }
    
    // MARK: - Privates
    
    private let data: IOToastData
    
    private let successBackgroundColor: Color
    private let errorBackgroundColor: Color
    private let warningBackgroundColor: Color
    private let infoBackgroundColor: Color
    
    private let successTextColor: Color
    private let errorTextColor: Color
    private let warningTextColor: Color
    private let infoTextColor: Color
    
    private let titleFont: IOFontType
    private let messageFont: IOFontType
    
    @Namespace private var viewSpace
    @State private var backgroundHeight: CGFloat = 0
    @State private var offsetY: CGFloat = -350
    
    private var backgroundColor: Color {
        switch data.type {
        case .success:
            return successBackgroundColor
            
        case .error:
            return errorBackgroundColor
            
        case .warning:
            return warningBackgroundColor
            
        case .info:
            return infoBackgroundColor
        }
    }
    
    private var textColor: Color {
        switch data.type {
        case .success:
            return successTextColor
            
        case .error:
            return errorTextColor
            
        case .warning:
            return warningTextColor
            
        case .info:
            return infoTextColor
        }
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                backgroundColor
                    .frame(height: backgroundHeight)
                
                VStack(alignment: .leading) {
                    if let title = data.title {
                        Text(title)
                            .font(type: titleFont)
                            .foregroundColor(textColor)
                    }
                    
                    Text(data.message)
                        .font(type: messageFont)
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 4)
                }
                .padding(.top, proxy.safeAreaInsets.top)
                .padding(16)
                .background(GeometryReader { geo in
                    let contentSize = geo.frame(in: .named(viewSpace)).size
                    Color.clear
                        .preference(
                            key: HeightPreferenceKey.self,
                            value: contentSize.height
                        )
                })
            }
            .frame(minHeight: 0)
            .ignoresSafeArea(.all, edges: [.top])
            .offset(x: 0, y: offsetY)
            .onPreferenceChange(HeightPreferenceKey.self) { value in
                backgroundHeight = value
                
                if offsetY < 0 {
                    animateToast()
                }
            }
            .onAppear {
                if backgroundHeight > 0 {
                    animateToast()
                }
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        _ data: IOToastData,
        successBackgroundColor: Color = .green,
        errorBackgroundColor: Color = .red,
        warningBackgroundColor: Color = .yellow,
        infoBackgroundColor: Color = .gray,
        successTextColor: Color = .white,
        errorTextColor: Color = .white,
        warningTextColor: Color = .white,
        infoTextColor: Color = .white,
        titleFont: IOFontType = .systemSemibold(14),
        messageFont: IOFontType = .systemRegular(14)
    ) {
        self.data = data
        
        self.successBackgroundColor = successBackgroundColor
        self.errorBackgroundColor = errorBackgroundColor
        self.warningBackgroundColor = warningBackgroundColor
        self.infoBackgroundColor = infoBackgroundColor
        
        self.successTextColor = successTextColor
        self.errorTextColor = errorTextColor
        self.warningTextColor = warningTextColor
        self.infoTextColor = infoTextColor
        
        self.titleFont = titleFont
        self.messageFont = messageFont
    }
    
    // MARK: - Helper Methods
    
    private func animateToast() {
        withAnimation(
            Animation
                .easeInOut(duration: 0.25)
        ) {
            offsetY = 0
        }
    }
}

#if DEBUG
struct IOToastView_Previews: PreviewProvider {
    
    struct IOToastViewDemo: View {
        
        var body: some View {
            IOToastView(
                IOToastData(
                    .info,
                    title: "Hello",
                    message: "Lorem ipsum dolor sit amet"
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return IOToastViewDemo()
    }
}
#endif
