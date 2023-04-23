// 
//  RegisterMRZFlashButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct RegisterMRZFlashButton: View {
    
    // MARK: - Privates
    
    @Binding private var flashEnabled: Bool
    
    @State private var isFlashEnabled = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if isFlashEnabled {
                IOButton {
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .shadow(
                            color: Color(white: 0, opacity: 0.3),
                            radius: 3,
                            x: 0,
                            y: 0
                        )
                }
                .setClick {
                    flashEnabled = false
                }
            } else {
                IOButton {
                    Image(systemName: "bolt.slash.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .shadow(
                            color: Color(white: 0, opacity: 0.3),
                            radius: 3,
                            x: 0,
                            y: 0
                        )
                }
                .setClick {
                    flashEnabled = true
                }
            }
        }
        .onChange(of: flashEnabled) { newValue in
            isFlashEnabled = newValue
        }
        .frame(width: 33, height: 52)
    }
    
    // MARK: - Initialization Methods
    
    init(
        isFlashEnabled: Binding<Bool>
    ) {
        self._flashEnabled = isFlashEnabled
    }
}

#if DEBUG
struct RegisterMRZFlashButton_Previews: PreviewProvider {
    
    struct RegisterMRZFlashButtonDemo: View {
        
        var body: some View {
            RegisterMRZFlashButton(
                isFlashEnabled: Binding.constant(false)
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return RegisterMRZFlashButtonDemo()
            .previewLayout(.sizeThatFits)
    }
}
#endif
