//
//  DiscoverCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 3.09.2022.
//

import SwiftUI

struct DiscoverCellView: View {
    
    private var uiModel: DiscoverUIModel
    private var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Image()
                .from(publicId: uiModel.imagePublicId)
                .frame(width: (width > 32) ? width - 32 : width, height: width)
                .clipped()
            
            HStack(alignment: .top) {
                Image()
                    .from(publicId: uiModel.userAvatarPublicId)
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(uiModel.userNameAndSurname)
                        .font(type: .bold(13))
                    Text(uiModel.userName)
                        .font(type: .regular(11))
                        .foregroundColor(.black.opacity(0.8))
                }
                
                Spacer()
                
                Text(uiModel.messageTime)
                    .font(type: .thin(12))
                    .foregroundColor(.colorPlaceholder)
            }
            .padding(.top, 16)
        }
        .padding([.trailing, .leading], 16)
        .padding(.top, 24)
    }
    
    init(uiModel: DiscoverUIModel, width: CGFloat) {
        self.uiModel = uiModel
        self.width = width
    }
}

struct DiscoverCellView_Previews: PreviewProvider {
    static var previews: some View {
        let uiModel = DiscoverUIModel(
            imagePublicId: "pwGallery3",
            userName: "@ridzjcob!",
            userNameAndSurname: "Ridhwan Nordin",
            userAvatarPublicId: "pwChatAvatar",
            messageTime: "16 min ago"
        )
        
        DiscoverCellView(uiModel: uiModel, width: 375)
            .previewLayout(.sizeThatFits)
    }
}
