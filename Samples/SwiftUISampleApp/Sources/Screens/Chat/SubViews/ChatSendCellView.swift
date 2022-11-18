//
//  ChatSendCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct ChatSendCellView: View {
    
    private var uiModel: ChatItemUIModel
    
    var body: some View {
        HStack(alignment: .top) {
            Text(uiModel.chatMessage)
                .font(type: .medium(13))
                .foregroundColor(.colorChatSendMessage)
                .padding([.top, .leading, .bottom], 16)
                .padding(.trailing, 14)
                .background(
                    IORoundedRect(
                        corners: [.topLeft(6), .topRight(0), .bottomLeft(6), .bottomRight(6)]
                    ).fill(Color.colorPassthrought)
                )
                .padding(.leading, 16)
            VStack {
                profilePictureImage
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                Text(uiModel.messageTime)
                    .foregroundColor(.colorPlaceholder)
                    .font(type: .thin(8))
            }
        }
        .padding(.top, 24)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity, alignment: .topTrailing)
    }
    
    private var profilePictureImage: AnyView {
        if let profilePicturePublicId = uiModel.imagePublicID, !profilePicturePublicId.isEmpty {
            let profilePictureImage = Image()
                .from(publicId: profilePicturePublicId)
            return AnyView(profilePictureImage)
        } else {
            let profilePictureImage = Image(systemName: "person.crop.circle")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
            return AnyView(profilePictureImage)
        }
    }
    
    init(uiModel: ChatItemUIModel) {
        self.uiModel = uiModel
    }
}

struct ChatSendCellView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        let uiModel = ChatItemUIModel(
            id: 0,
            imagePublicID: "pwProfilePicture",
            chatMessage: "A fast 50mm like f1.8 would help with the bokeh. I’ve been using primes as they tend to get a bit sharper images.",
            isLastMessage: false,
            isSend: true,
            messageTime: "16 min ago"
        )
        
        return ChatSendCellView(uiModel: uiModel)
            .previewLayout(.sizeThatFits)
    }
}
