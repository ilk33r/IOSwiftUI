// 
//  StoryHeaderView.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.07.2023.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

struct StoryHeaderView: View {
    
    // MARK: - Privates
    
    private let relativeDate: String
    private let userNameAndSurname: String
    private let userProfilePicturePublicId: String?
    private let currentItem: Binding<Int>
    
    @Binding private var isPresented: Bool
    
    private var isVisible: Binding<Bool>
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            IOLinearProgressView(
                progressCount: 6,
                itemSpace: 8,
                backgroundColor: .colorImage.opacity(0.6),
                activeColor: .colorImage,
                changeSeconds: 8,
                currentItem: currentItem, 
                isActive: isVisible
            )
            .frame(height: 2)
            .padding(.top, 8)
            .padding([.leading, .trailing], 8)
            
            HStack(spacing: 0) {
                ProfilePictureImageView(
                    imagePublicID: Binding.constant(userProfilePicturePublicId)
                )
                .foregroundColor(.colorImage)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(userNameAndSurname)
                        .font(type: .medium(12))
                        .foregroundColor(.colorImage)
                    
                    Text(relativeDate)
                        .font(type: .regular(12))
                        .foregroundColor(.colorImage)
                }
                .padding(.leading, 12)
                
                Spacer()
                
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
                .padding(.top, 8)
            }
            .padding(.top, 4)
            .padding([.leading, .trailing], 8)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        relativeDate: String,
        userNameAndSurname: String,
        userProfilePicturePublicId: String?,
        currentItem: Binding<Int>,
        isVisible: Binding<Bool>,
        isPresented: Binding<Bool>
    ) {
        self.relativeDate = relativeDate
        self.userNameAndSurname = userNameAndSurname
        self.userProfilePicturePublicId = userProfilePicturePublicId
        self.currentItem = currentItem
        self.isVisible = isVisible
        self._isPresented = isPresented
    }
}

#if DEBUG
struct StoryHeaderView_Previews: PreviewProvider {
    
    struct StoryHeaderViewDemo: View {
        
        @State private var currentItem = 0
        
        var body: some View {
            StoryHeaderView(
                relativeDate: "1 Hour Ago",
                userNameAndSurname: "Lorem",
                userProfilePicturePublicId: nil,
                currentItem: $currentItem, 
                isVisible: Binding.constant(true),
                isPresented: Binding.constant(true)
            )
            .background(Color.black)
        }
    }
    
    static var previews: some View {
        prepare()
        return StoryHeaderViewDemo()
    }
}
#endif
