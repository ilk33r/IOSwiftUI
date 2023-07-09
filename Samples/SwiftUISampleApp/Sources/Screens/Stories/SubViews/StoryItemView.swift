// 
//  StoryItemView.swift
//
//
//  Created by Adnan ilker Ozcan on 8.07.2023.
//

import Foundation
import SwiftUI

struct StoryItemView: View {
    
    // MARK: - Privates
    
    private var images: [StoryItemUIModel]
    
    @Binding private var isPresented: Bool
    
    @State private var currentImageIndex = 0
    @State private var currentImagePublicId: String?
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Image()
                    .from(publicId: $currentImagePublicId)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                    .zIndex(20)
                
                ZStack(alignment: .topTrailing) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 18, height: 18)
                    }
                    .frame(
                        width: 40,
                        height: 40,
                        alignment: .topTrailing
                    )
                    .padding([.top, .trailing], 24)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .zIndex(30)
            }
        }
        .onAppear {
            let currentItem = images[currentImageIndex]
            currentImagePublicId = currentItem.publicId
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        images: [StoryItemUIModel],
        isPresented: Binding<Bool>
    ) {
        self.images = images
        self._isPresented = isPresented
    }
}

#if DEBUG
struct StoryItemView_Previews: PreviewProvider {
    
    struct StoryItemViewDemo: View {
        
        var body: some View {
            StoryItemView(
                images: StoriesPreviewData.itemPreviewData,
                isPresented: Binding.constant(true)
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return StoryItemViewDemo()
    }
}
#endif
