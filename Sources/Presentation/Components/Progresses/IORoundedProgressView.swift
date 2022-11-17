//
//  IORoundedProgressView.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI

public struct IORoundedProgressView: View {
    
    // MARK: - Defs
    
    public typealias FinishHandler = () -> Void
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    @State private var circleTrim: CGFloat = 0
    @State private var secondsLeft: Int = 90
    @State private var timerCancellable: IOCancellable?
    
    private let isActive: Binding<Bool>
    private let activeCircleBackgroundColor: Color
    private let circleBackgroundColor: Color
    private let fontType: IOFontType
    private let initialSecondsLeft: Int
    private let lineWidth: CGFloat
    private let textColor: Color
    private let onFinish: FinishHandler?
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .fill(circleBackgroundColor)
                .zIndex(1)
            
            Circle()
                .trim(from: 0, to: circleTrim)
                .rotation(.degrees(-90))
                .stroke(lineWidth: lineWidth)
                .foregroundColor(activeCircleBackgroundColor)
                .zIndex(2)
            
            Text("\(secondsLeft)")
                .font(type: fontType)
                .foregroundColor(textColor)
                .zIndex(3)
        }
        .onChange(of: isActive.wrappedValue) { newValue in
            if newValue {
                updateTimer()
            } else {
                timerCancellable?.cancel()
            }
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        secondsLeft: Int,
        isActive: Binding<Bool>,
        activeCircleBackgroundColor: Color = .blue,
        circleBackgroundColor: Color = .gray,
        fontType: IOFontType = .systemSemibold(24),
        lineWidth: CGFloat = 6,
        textColor: Color = .gray,
        onFinish: FinishHandler?
    ) {
        self.isActive = isActive
        self.activeCircleBackgroundColor = activeCircleBackgroundColor
        self.circleBackgroundColor = circleBackgroundColor
        self.fontType = fontType
        self.initialSecondsLeft = secondsLeft
        self.lineWidth = lineWidth
        self.textColor = textColor
        self.onFinish = onFinish
        self.secondsLeft = secondsLeft
        self.circleTrim = 0
    }
    
    // MARK: - Helper Methods
    
    private func updateTimer() {
        if timerCancellable != nil {
            timerCancellable?.cancel()
        }
        
        timerCancellable = thread.runOnMainThread(afterMilliSecond: 1000) {
            secondsLeft -= 1
            let secondsPercent = CGFloat(secondsLeft) / CGFloat(initialSecondsLeft)
            circleTrim = 1 - secondsPercent
            
            if secondsLeft > 0 {
                updateTimer()
            } else {
                isActive.wrappedValue = false
                onFinish?()
            }
        }
    }
}

struct IORoundedProgressView_Previews: PreviewProvider {
    
    struct IORoundedProgressViewDemo: View {
        
        @State private var isActive = true
        
        var body: some View {
            IORoundedProgressView(
                secondsLeft: 90,
                isActive: $isActive,
                onFinish: {
                    
                }
            )
            .frame(width: 80, height: 80)
        }
    }
    
    static var previews: some View {
        IORoundedProgressViewDemo()
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
