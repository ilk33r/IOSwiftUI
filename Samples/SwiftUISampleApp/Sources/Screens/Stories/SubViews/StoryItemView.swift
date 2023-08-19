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
    private var pageNumber: Int
    private var isPresented: Binding<Bool>
    
    @Binding private var currentPage: Int
    
    @State private var currentImageIndex = 0
    @State private var currentImagePublicId: String?
    @State private var relativeDate = ""
    @State private var userNameAndSurname = ""
    @State private var userProfilePicturePublicId: String?
    @State private var isVisible: Bool
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Image()
                    .from(publicId: $currentImagePublicId)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                    .allowsHitTesting(false)
                    .zIndex(20)
                
                ZStack(alignment: .topTrailing) {
                    StoryHeaderView(
                        relativeDate: relativeDate,
                        userNameAndSurname: userNameAndSurname,
                        userProfilePicturePublicId: userProfilePicturePublicId,
                        currentItem: $currentImageIndex, 
                        isVisible: $isVisible,
                        isPresented: isPresented
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .zIndex(30)
            }
        }
        .onAppear {
            let currentItem = images[currentImageIndex]
            currentImagePublicId = currentItem.publicId
            relativeDate = currentItem.relativeDate
            userNameAndSurname = currentItem.userNameAndSurname
            userProfilePicturePublicId = currentItem.userProfilePicturePublicId
            isVisible = currentPage == pageNumber
        }
        .onChange(of: currentImageIndex) { newValue in
            let currentItem = images[newValue]
            currentImagePublicId = currentItem.publicId
            relativeDate = currentItem.relativeDate
            userNameAndSurname = currentItem.userNameAndSurname
            userProfilePicturePublicId = currentItem.userProfilePicturePublicId
        }
        .onChange(of: currentPage) { value in
            isVisible = value == pageNumber
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        images: [StoryItemUIModel],
        pageNumber: Int,
        currentPage: Binding<Int>,
        isPresented: Binding<Bool>
    ) {
        self.images = images
        self.pageNumber = pageNumber
        self.isPresented = isPresented
        self._currentPage = currentPage
        
        self._isVisible = State(initialValue: pageNumber == currentPage.wrappedValue)
    }
}

#if DEBUG
struct StoryItemView_Previews: PreviewProvider {
    
    struct StoryItemViewDemo: View {
        
        var body: some View {
            StoryItemView(
                images: StoriesPreviewData.itemPreviewData,
                pageNumber: 0,
                currentPage: Binding.constant(0),
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
