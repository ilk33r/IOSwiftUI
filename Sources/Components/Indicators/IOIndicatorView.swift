//
//  IOIndicatorView.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import SwiftUI

public struct IOIndicatorView: View {
    
    private var backgroundColor: Color
    private var circleColor: Color
    
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
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
                        self.isCircleRotating.toggle()
                    }
                    withAnimation(
                        Animation
                            .linear(duration: 1)
                            .delay(0.5)
                            .repeatForever(autoreverses: true)
                    ) {
                        self.animateStart.toggle()
                    }
                    withAnimation(
                        Animation
                            .linear(duration: 1)
                            .delay(1)
                            .repeatForever(autoreverses: true)
                    ) {
                        self.animateEnd.toggle()
                    }
                }
        }
    }
    
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
    
    public func backgroundColor(_ color: Color) -> IOIndicatorView {
        return IOIndicatorView(
            backgroundColor: color,
            circleColor: circleColor
        )
    }
    
    public func circleColor(_ color: Color) -> IOIndicatorView {
        return IOIndicatorView(
            backgroundColor: backgroundColor,
            circleColor: color
        )
    }
}

struct IOIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IOIndicatorView()
    }
}
