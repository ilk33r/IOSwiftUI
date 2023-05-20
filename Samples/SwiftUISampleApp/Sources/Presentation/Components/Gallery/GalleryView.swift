//
//  GalleryView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

public struct GalleryView: View {
    
    // MARK: - Privates
    
    private let leftGalleryData: [GalleryCellData]
    private let rightGalleryData: [GalleryCellData]
    
    @Binding private var insetTop: CGFloat
    @Binding private var scrollContentSize: CGSize
    @Binding private var scrollOffset: CGFloat
    @Binding private var tapIndex: Int
    @Binding private var viewSize: CGSize
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            IOObservableScrollView(
                contentSize: $scrollContentSize,
                scrollOffset: $scrollOffset
            ) { _ in
                let itemWidth = (proxy.size.width - 16 - 16 - 9) / 2
                Color.clear
                    .frame(height: insetTop)
                HStack(alignment: .top, spacing: 9) {
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(leftGalleryData) { it in
                            GalleryCellView(
                                imagePublicId: it.imagePublicId,
                                type: it.type,
                                width: itemWidth
                            )
                            .onTapGesture {
                                tapIndex = it.index
                            }
                        }
                    }
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(rightGalleryData) { it in
                            GalleryCellView(
                                imagePublicId: it.imagePublicId,
                                type: it.type,
                                width: itemWidth
                            )
                            .onTapGesture {
                                tapIndex = it.index
                            }
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
            .onAppear {
                viewSize = proxy.size
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        insetTop: Binding<CGFloat>,
        scrollContentSize: Binding<CGSize>,
        scrollOffset: Binding<CGFloat>,
        tapIndex: Binding<Int>,
        viewSize: Binding<CGSize>,
        galleryImages: [String]
    ) {
        var leftGalleryData = [GalleryCellData]()
        var rightGalleryData = [GalleryCellData]()
        
        galleryImages.enumerated().forEach { it in
            if it.offset.isMultiple(of: 2) {
                let isSmall = it.offset.isMultiple(of: 4)
                leftGalleryData.append(
                    GalleryCellData(
                        imagePublicId: it.element,
                        index: it.offset,
                        type: (isSmall) ? .small : .normal
                    )
                )
            } else {
                rightGalleryData.append(
                    GalleryCellData(
                        imagePublicId: it.element,
                        index: it.offset,
                        type: .normal
                    )
                )
            }
        }
        
        self.leftGalleryData = leftGalleryData
        self.rightGalleryData = rightGalleryData
        self._insetTop = insetTop
        self._scrollContentSize = scrollContentSize
        self._scrollOffset = scrollOffset
        self._tapIndex = tapIndex
        self._viewSize = viewSize
    }
}

#if DEBUG
struct GalleryView_Previews: PreviewProvider {
    
    struct GalleryViewDemo: View {
        
        @State var insetTop: CGFloat = 0
        @State var scrollContentSize: CGSize = .zero
        @State var scrollOffset: CGFloat = 0
        @State var tapIndex: Int = 0
        @State var viewSize: CGSize = .zero
        
        var body: some View {
            GalleryView(
                insetTop: $insetTop,
                scrollContentSize: $scrollContentSize,
                scrollOffset: $scrollOffset,
                tapIndex: $tapIndex,
                viewSize: $viewSize,
                galleryImages: GalleryViewPreviewData.previewData
            )
        }
    }
     
    static var previews: some View {
        prepare()
        return GalleryViewDemo()
    }
}
#endif
