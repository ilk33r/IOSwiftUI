//
//  IOIndicatorView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import SwiftUI

public struct IOIndicatorView: View {
    
    // MARK: - Privates
    
    private let backgroundColor: Color
    private let circleColor: Color
    
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .fill(backgroundColor)
                .frame(width: 75, height: 75)
            
            Circle()
                .trim(from: animateStart ? 1 / 3 : 1 / 9, to: animateEnd ? 2 / 5 : 1)
                .stroke(lineWidth: 6)
                .rotationEffect(.degrees(isCircleRotating ? -360 : 0))
                .frame(width: 75, height: 75)
                .foregroundColor(circleColor)
                .onAppear {
                    withAnimation(
                        Animation
                            .linear(duration: 1)
                            .repeatForever(autoreverses: false)
                    ) {
                        isCircleRotating.toggle()
                    }
                    withAnimation(
                        Animation
                            .linear(duration: 1)
                            .delay(0.5)
                            .repeatForever(autoreverses: true)
                    ) {
                        animateStart.toggle()
                    }
                    withAnimation(
                        Animation
                            .linear(duration: 1)
                            .delay(1)
                            .repeatForever(autoreverses: true)
                    ) {
                        animateEnd.toggle()
                    }
                }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init() {
        self.init(
            backgroundColor: .gray,
            circleColor: .blue
        )
    }
    
    private init(
        backgroundColor: Color,
        circleColor: Color
    ) {
        self.backgroundColor = backgroundColor
        self.circleColor = circleColor
    }
    
    // MARK: - Modifiers
    
    public func backgroundColor(_ color: Color) -> IOIndicatorView {
        Self(
            backgroundColor: color,
            circleColor: circleColor
        )
    }
    
    public func circleColor(_ color: Color) -> IOIndicatorView {
        Self(
            backgroundColor: backgroundColor,
            circleColor: color
        )
    }
}

#if DEBUG
struct IOIndicatorView_Previews: PreviewProvider {
    
    struct IOIndicatorViewDemo: View {
        
        var body: some View {
            IOIndicatorView()
        }
    }
    
    static var previews: some View {
        prepare()
        return IOIndicatorView()
    }
}
#endif
