//
//  RoundedProgressView.swift
//  
//
//  Created by Adnan ilker Ozcan on 12.11.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon

public struct RoundedProgressView: View {
    
    // MARK: - Privates
    
    private let isActive: Binding<Bool>
    private let onFinish: IORoundedProgressView.FinishHandler?
    private let secondsLeft: Int
    
    // MARK: - Body
    
    public var body: some View {
        IORoundedProgressView(
            secondsLeft: secondsLeft,
            isActive: isActive,
            activeCircleBackgroundColor: .black,
            circleBackgroundColor: .colorPlaceholder,
            fontType: .medium(28),
            lineWidth: 3,
            textColor: .black,
            onFinish: onFinish
        )
    }
    
    // MARK: - Initialization Methods
    
    public init(
        secondsLeft: Int,
        isActive: Binding<Bool>,
        onFinish: IORoundedProgressView.FinishHandler?
    ) {
        self.isActive = isActive
        self.onFinish = onFinish
        self.secondsLeft = secondsLeft
    }
}

#if DEBUG
struct RoundedProgressView_Previews: PreviewProvider {

    struct RoundedProgressViewDemo: View {
        
        @State private var isActive = true
        
        var body: some View {
            RoundedProgressView(
                secondsLeft: 90,
                isActive: $isActive,
                onFinish: {
                    
                }
            )
            .frame(width: 80, height: 80)
        }
    }
    
    static var previews: some View {
        RoundedProgressViewDemo()
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
#endif
