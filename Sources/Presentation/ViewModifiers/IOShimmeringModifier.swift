//
//  IOShimmeringModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.12.2022.
//

import Foundation
import SwiftUI

public extension View {
    
    @ViewBuilder
    func shimmering(
        active: Bool
    ) -> some View {
        if active {
            modifier(IOShimmer())
        } else {
            self
        }
    }
}

struct IOShimmer: ViewModifier {
    
    // MARK: - Defs
    
    struct AnimatedMask: AnimatableModifier {
        
        var phase: CGFloat = 0
        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(GradientMask(phase: phase).scaleEffect(3))
        }
    }
    
    struct GradientMask: View {

        let phase: CGFloat
        let centerColor = Color.black.opacity(0.6)
        let edgeColor = Color.black.opacity(0.3)

        var body: some View {
            LinearGradient(gradient:
                Gradient(stops: [
                    .init(color: edgeColor, location: phase),
                    .init(color: centerColor, location: phase + 0.1),
                    .init(color: edgeColor, location: phase + 0.2)
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    // MARK: - Privates
    
    private let animation: Animation
    
    @State private var phase: CGFloat = 0
    
    // MARK: - Initialization Methods
    
    init() {
        self.animation = Animation.linear(duration: 1.5)
            .repeatForever(autoreverses: false)
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedMask(phase: phase).animation(animation)
            )
            .onAppear { phase = 0.8 }
    }
}
