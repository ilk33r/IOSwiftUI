//
//  GalleryView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI
import IOSwiftUIComponents

public struct GalleryView: View {
    
    private let leftGalleryData: [GalleryCellData]
    private let rightGalleryData: [GalleryCellData]
    
    @Binding private var insetTop: CGFloat
    @Binding private var scrollOffset: CGFloat
    
    public var body: some View {
        GeometryReader { proxy in
            ObservableScrollView(scrollOffset: $scrollOffset) { _ in
                let itemWidth = (proxy.size.width - 16 - 16 - 9) / 2
                Color.clear
                    .frame(height: insetTop)
                HStack(alignment: .top, spacing: 9) {
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(leftGalleryData) { it in
                            GalleryCellView(
                                image: it.image,
                                type: it.type,
                                width: itemWidth)
                        }
                    }
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(rightGalleryData) { it in
                            GalleryCellView(
                                image: it.image,
                                type: it.type,
                                width: itemWidth)
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
        }
    }
    
    public init(
        insetTop: Binding<CGFloat>,
        scrollOffset: Binding<CGFloat>,
        galleryImages: [Image]
    ) {
        var leftGalleryData = [GalleryCellData]()
        var rightGalleryData = [GalleryCellData]()
        
        galleryImages.enumerated().forEach { it in
            if it.offset % 2 == 0 {
                let isSmall = it.offset % 4 == 0
                leftGalleryData.append(
                    GalleryCellData(
                        image: it.element,
                        type: (isSmall) ? .small : .normal
                    )
                )
            } else {
                rightGalleryData.append(
                    GalleryCellData(
                        image: it.element,
                        type: .normal
                    )
                )
            }
        }
        
        self.leftGalleryData = leftGalleryData
        self.rightGalleryData = rightGalleryData
        self._insetTop = insetTop
        self._scrollOffset = scrollOffset
    }
}

struct GalleryView_Previews: PreviewProvider {
    
    struct GalleryViewDemo: View {
        
        @State var insetTop: CGFloat = 0
        @State var scrollOffset: CGFloat = 0
        
        let galleryImages = [
            Image("pwGallery0"),
            Image("pwGallery1"),
            Image("pwGallery2"),
            Image("pwGallery3"),
            Image("pwGallery4"),
            Image("pwGallery5"),
            Image("pwGallery0"),
            Image("pwGallery1"),
            Image("pwGallery2"),
            Image("pwGallery3"),
            Image("pwGallery4"),
            Image("pwGallery5"),
            Image("pwGallery0"),
            Image("pwGallery1"),
            Image("pwGallery2"),
            Image("pwGallery3"),
            Image("pwGallery4"),
            Image("pwGallery5")
        ]
        
        var body: some View {
            GalleryView(
                insetTop: $insetTop,
                scrollOffset: $scrollOffset,
                galleryImages: galleryImages
            )
        }
    }
     
    static var previews: some View {
        GalleryViewDemo()
    }
}
