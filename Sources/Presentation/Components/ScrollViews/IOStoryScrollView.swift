// 
//  IOStoryScrollView.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.07.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

public struct IOStoryScrollView<Content, Item>: View where Content: View, Item: Identifiable {
    
    // MARK: - Privates
    
    private let content: (_ item: Item) -> Content
    private let items: [Item]
    
    @State private var itemWidth: CGFloat = 0
    @State private var rootViewWidth: CGFloat = 0
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { geometry in
            IOSnapScrollView(
                itemWidth: Binding.constant(geometry.size.width),
                rootViewWidth: Binding.constant(geometry.size.width * CGFloat(items.count))
            ) {
                HStack(spacing: 0) {
                    ForEach(items) { item in
                        GeometryReader { itemGeometry in
                            let itemWidth = geometry.size.width
                            let frame = itemGeometry.frame(in: .global)
                            let degrees = calculateDegress(
                                frame: frame,
                                itemWidth: itemWidth
                            )
                            
                            content(item)
                                .rotation3DEffect(
                                    Angle(
                                        degrees: Double(degrees)
                                    ),
                                    axis: (x: 0, y: 1, z: 0),
                                    anchor: anchor(frame: frame, itemWidth: itemWidth),
                                    anchorZ: 0.0,
                                    perspective: 1.0
                                )
                        }
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height
                        )
                    }
                }
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        items: [Item],
        @ViewBuilder content: @escaping (_ item: Item) -> Content
    ) {
        self.items = items
        self.content = content
    }
    
    // MARK: - Helper Methods
    
    private func calculateDegress(frame: CGRect, itemWidth: CGFloat) -> CGFloat {
        let maxRotation = itemWidth / 2
        
        if frame.origin.x <= 0 {
            let rorationDegree = frame.origin.x * 45 / maxRotation
            return rorationDegree
        } else {
            let startDegree = frame.origin.x - itemWidth
            let rorationDegree = startDegree * 45 / maxRotation
            return rorationDegree + 45
        }
    }
    
    private func anchor(frame: CGRect, itemWidth: CGFloat) -> UnitPoint {
        if frame.origin.x >= 0 {
            return .leading
        }
        
        return .trailing
    }
}

#if DEBUG
struct IOStoryScrollView_Previews: PreviewProvider {
    
    struct StoryItem: Identifiable {
        
        let name: String
        let back: Color
        
        var id = UUID()
    }
    
    struct IOStoryScrollViewDemo: View {
        
        var previewItems = [
            StoryItem(name: "Lorem", back: .gray),
            StoryItem(name: "Ipsum", back: .red),
            StoryItem(name: "Dolor", back: .green),
            StoryItem(name: "Sit", back: .blue),
            StoryItem(name: "Amet", back: .gray),
            StoryItem(name: "consectetur", back: .red),
            StoryItem(name: "adipiscing", back: .yellow)
        ]
        
        var body: some View {
            IOStoryScrollView(items: previewItems) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(item.back)
                    Text(item.name)
                }
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return IOStoryScrollViewDemo()
    }
}
#endif
