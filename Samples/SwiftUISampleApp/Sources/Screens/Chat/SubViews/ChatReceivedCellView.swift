//
//  ChatReceivedCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

struct ChatReceivedCellView: View {
    
    // MARK: - Privates
    
    private var uiModel: ChatItemUIModel
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                ProfilePictureImageView(imagePublicID: uiModel.imagePublicID)
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                Text(uiModel.messageTime)
                    .foregroundColor(.colorPlaceholder)
                    .font(type: .thin(8))
            }
            Text(uiModel.chatMessage)
                .font(type: .regular(13))
                .foregroundColor(uiModel.isLastMessage ? .colorChatLastMessage : .black)
                .padding([.top, .leading, .bottom], 16)
                .padding(.trailing, 14)
                .background(
                    IORoundedRect(
                        corners: [.topLeft(0), .topRight(6), .bottomLeft(6), .bottomRight(6)]
                    ).fill(Color.colorPassthrought)
                )
                .padding(.leading, 16)
        }
        .padding(.top, 24)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
    }
    
    // MARK: - Initialization Methods
    
    init(uiModel: ChatItemUIModel) {
        self.uiModel = uiModel
    }
}

#if DEBUG
struct ChatReceivedCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        let uiModel = ChatItemUIModel(
            id: 0,
            imagePublicID: "pwProfilePicture",
            chatMessage: "Really love your most recent photo. I’ve been trying to capture the same thing for a few months and would love some tips!",
            isLastMessage: false,
            isSend: false,
            messageTime: "16 min ago"
        )
        
        return ChatReceivedCellView(uiModel: uiModel)
            .previewLayout(.sizeThatFits)
    }
}
#endif
