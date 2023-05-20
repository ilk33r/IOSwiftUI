//
//  IOPopoverView.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import SwiftUI

public struct IOPopoverView<Content: View, PopoverContent: View>: View {
    
    // MARK: - Privates
    
    private let content: () -> Content
    private let popoverContent: () -> PopoverContent
    private let size: CGSize?
    
    @Binding private var show: Bool
    
    // MARK: - Body
    
    public var body: some View {
        content()
            .background(
                IOPopoverWrapperView(
                    show: $show,
                    size: size,
                    content: popoverContent
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
    }
    
    // MARK: - Initialization Methods
    
    public init(
        show: Binding<Bool>,
        size: CGSize?,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder popoverContent: @escaping () -> PopoverContent
    ) {
        self._show = show
        self.content = content
        self.popoverContent = popoverContent
        self.size = size
    }
}

#if DEBUG
struct IOPopoverView_Previews: PreviewProvider {
    
    struct IOPopoverViewDemo: View {
        
        @State private var show = false
        
        var body: some View {
            IOPopoverView(
                show: $show,
                size: .init(width: 220, height: 60)
            ) {
                ZStack {
                    Button("Popover") {
                        show = true
                    }
                }
            } popoverContent: {
                Text("Popover content!")
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return IOPopoverViewDemo()
    }
}
#endif
