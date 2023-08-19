// 
//  StoryItemView.swift
//
//
//  Created by Adnan ilker Ozcan on 8.07.2023.
//

import Foundation
import IOSwiftUIInfrastructure
import SwiftUI

struct StoryItemView: View {
    
    // MARK: - Privates
    
    private var images: [StoryItemUIModel]
    private var pageNumber: Int
    private var totalPage: Int
    
    @Binding private var isPresented: Bool
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
                
                ZStack(alignment: .topLeading) {
                    HStack {
                        Rectangle()
                            .fill(Color.clear)
                            .setClick {
                                let newImageIndex = currentImageIndex - 1
                                if newImageIndex >= 0 {
                                    currentImageIndex = newImageIndex
                                } else {
                                    previousPage()
                                }
                            }
                            .frame(width: 100)
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(Color.clear)
                            .setClick {
                                let newImageIndex = currentImageIndex + 1
                                if newImageIndex < images.count {
                                    currentImageIndex = newImageIndex
                                } else {
                                    nextPage()
                                }
                            }
                            .frame(width: 100)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .zIndex(30)
                
                ZStack(alignment: .topTrailing) {
                    StoryHeaderView(
                        pageCount: images.count,
                        relativeDate: relativeDate,
                        userNameAndSurname: userNameAndSurname,
                        userProfilePicturePublicId: userProfilePicturePublicId,
                        currentItem: $currentImageIndex, 
                        isVisible: $isVisible,
                        isPresented: _isPresented
                    ) {
                        nextPage()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .zIndex(40)
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
            if newValue < 0 {
                previousPage()
                return
            }
            
            if newValue >= images.count {
                nextPage()
                return
            }
            
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
        totalPage: Int,
        currentPage: Binding<Int>,
        isPresented: Binding<Bool>
    ) {
        self.images = images
        self.pageNumber = pageNumber
        self.totalPage = totalPage
        self._isPresented = isPresented
        self._currentPage = currentPage
        
        self._isVisible = State(initialValue: pageNumber == currentPage.wrappedValue)
    }
    
    // MARK: - Helper Methods
    
    private func nextPage() {
        let newPage = currentPage + 1
        if newPage < totalPage {
            currentPage = newPage
        } else {
            isPresented = false
        }
    }
    
    private func previousPage() {
        let newPage = currentPage - 1
        if newPage >= 0 {
            currentPage = newPage
        }
    }
}

#if DEBUG
struct StoryItemView_Previews: PreviewProvider {
    
    struct StoryItemViewDemo: View {
        
        var body: some View {
            StoryItemView(
                images: StoriesPreviewData.itemPreviewData,
                pageNumber: 0, 
                totalPage: 1,
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
