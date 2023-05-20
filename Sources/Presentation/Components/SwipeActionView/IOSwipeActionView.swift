// 
//  IOSwipeActionView.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.05.2023.
//

import Foundation
import SwiftUI

public struct IOSwipeActionView<Content: View, Actions: View>: View {
    
    // MARK: - Privates
    
    private let buttonAreaWidth: CGFloat
    private let itemHeight: CGFloat
    private let contentView: () -> Content
    private let actionsView: () -> Actions
    
    @State private var deleteButtonIsHidden = true
    @State private var offset: CGSize = .zero
    
    // MARK: - Body
    
    public var body: some View {
        ZStack(alignment: .top) {
            actionsView()
                .zIndex(1)
                .hidden(isHidden: $deleteButtonIsHidden)
            
            contentView()
                .offset(x: offset.width, y: 0)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if deleteButtonIsHidden {
                                deleteButtonIsHidden = false
                            }
                            
                            let newOffset = gesture.translation.width
                            if newOffset <= 0 && newOffset >= -buttonAreaWidth {
                                offset.width = newOffset
                            } else if newOffset <= 0 {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset.width = -buttonAreaWidth
                                }
                            } else {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset = .zero
                                    deleteButtonIsHidden = true
                                }
                            }
                        }
                        .onEnded { _ in
                            if offset.width <= -buttonAreaWidth {
                                offset.width = -buttonAreaWidth
                            } else if offset.width < (-buttonAreaWidth) / 2 {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset.width = -buttonAreaWidth
                                }
                            } else {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset = .zero
                                    deleteButtonIsHidden = true
                                }
                            }
                        }
                )
                .zIndex(2)
        }
        .frame(height: itemHeight)
    }
    
    // MARK: - Initialization Methods
    
    public init(
        buttonAreaWidth: CGFloat,
        itemHeight: CGFloat,
        @ViewBuilder _ contentView: @escaping () -> Content,
        @ViewBuilder _ actionsView: @escaping () -> Actions
    ) {
        self.buttonAreaWidth = buttonAreaWidth
        self.itemHeight = itemHeight
        self.contentView = contentView
        self.actionsView = actionsView
    }
}

#if DEBUG
struct IOSwipeActionView_Previews: PreviewProvider {
    
    struct IOSwipeActionViewDemo: View {
        
        var body: some View {
            IOSwipeActionView(
                buttonAreaWidth: 88,
                itemHeight: 88, {
                    ZStack {
                        Text("SwipeActionView")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                }, {
                    HStack(alignment: .top) {
                        Spacer()
                        
                        Button {
                        } label: {
                            ZStack {
                                Color.red
                                    .cornerRadius(6)
                                Text("Delete")
                            }
                        }
                        .frame(width: 72, height: 62)
                    }
                }
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return IOSwipeActionViewDemo()
    }
}
#endif
