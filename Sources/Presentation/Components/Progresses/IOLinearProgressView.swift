// 
//  IOLinearProgressView.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.07.2023.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOLinearProgressView: View {
    
    // MARK: - Defs
    
    public typealias Handler = () -> Void
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private let progressCount: Int
    private let itemSpace: CGFloat
    private let backgroundColor: Color
    private let activeColor: Color
    private let changeSeconds: Int
    private let onFinish: Handler?
    
    @State private var timerCancellable: IOCancellable?
    @State private var isAnimating = false
    
    @Binding private var isActive: Bool
    @Binding private var currentItem: Int
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            HStack(spacing: itemSpace) {
                let radius = proxy.size.height / 2
                
                ForEach(0..<progressCount, id: \.self) { index in
                    if index < currentItem {
                        RoundedRectangle(cornerSize: CGSize(width: radius, height: radius))
                            .stroke(lineWidth: proxy.size.height)
                            .foregroundColor(activeColor)
                    } else if index == currentItem {
                        ZStack(alignment: .topLeading) {
                            GeometryReader { itemProxy in
                                RoundedRectangle(cornerSize: CGSize(width: radius, height: radius))
                                    .stroke(lineWidth: proxy.size.height)
                                    .foregroundColor(backgroundColor)
                                
                                RoundedRectangle(cornerSize: CGSize(width: radius, height: radius))
                                    .stroke(lineWidth: proxy.size.height)
                                    .foregroundColor(activeColor)
                                    .frame(width: isAnimating ? itemProxy.size.width : 0)
                            }
                        }
                        .frame(height: proxy.size.height)
                    } else {
                        RoundedRectangle(cornerSize: CGSize(width: radius, height: radius))
                            .stroke(lineWidth: proxy.size.height)
                            .foregroundColor(backgroundColor)
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .onChange(of: isActive) { value in
            isAnimating = false
            
            if value {
                updateTimer()
            } else {
                timerCancellable?.cancel()
            }
        }
        .onChange(of: currentItem) { _ in
            isAnimating = false
            
            thread.runOnMainThread(afterMilliSecond: 250) {
                updateTimer()
            }
        }
        .onAppear {
            isAnimating = false
            
            if isActive {
                updateTimer()
            }
        }
        .onDisappear {
            isAnimating = false
            timerCancellable?.cancel()
            timerCancellable = nil
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        progressCount: Int,
        itemSpace: CGFloat,
        backgroundColor: Color,
        activeColor: Color,
        changeSeconds: Int,
        currentItem: Binding<Int>,
        isActive: Binding<Bool>,
        onFinish: Handler? = nil
    ) {
        self.progressCount = progressCount
        self.itemSpace = itemSpace
        self.backgroundColor = backgroundColor
        self.activeColor = activeColor
        self.changeSeconds = changeSeconds
        self.onFinish = onFinish
        
        self._isActive = isActive
        self._currentItem = currentItem
    }
    
    // MARK: - Helper Methods
    
    private func updateTimer() {
        timerCancellable?.cancel()
        
        withAnimation(
            .linear(
                duration: TimeInterval(changeSeconds)
            )
        ) {
            isAnimating = true
        }
        
        timerCancellable = thread.runOnMainThread(afterMilliSecond: changeSeconds * 1000) {
            if currentItem < progressCount - 1 {
                currentItem += 1
            } else {
                onFinish?()
            }
        }
    }
}

#if DEBUG
struct IOLinearProgressView_Previews: PreviewProvider {
    
    struct IOLinearProgressViewDemo: View {
        
        @State private var currentItem = 1
        
        var body: some View {
            ZStack {
                IOLinearProgressView(
                    progressCount: 6,
                    itemSpace: 8,
                    backgroundColor: .white.opacity(0.6),
                    activeColor: .white,
                    changeSeconds: 8,
                    currentItem: $currentItem, 
                    isActive: Binding.constant(true)
                )
                .frame(height: 2)
            }
            .frame(maxHeight: .infinity)
            .background(Color.black)
        }
    }
    
    static var previews: some View {
        prepare()
        return IOLinearProgressViewDemo()
    }
}
#endif
