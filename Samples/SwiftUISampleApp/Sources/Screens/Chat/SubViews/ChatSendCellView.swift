//
//  ChatSendCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

struct ChatSendCellView: View {
    
    // MARK: - Privates
    
    private let uiModel: ChatItemUIModel
    
    @State private var imagePublicID: String?
    
    // MARK: - Body
    
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
                ProfilePictureImageView(
                    imagePublicID: $imagePublicID
                )
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
        .frame(
            maxWidth: .infinity,
            alignment: .topTrailing
        )
    }
    
    // MARK: - Initialization Methods
    
    init(uiModel: ChatItemUIModel) {
        self.uiModel = uiModel
        self._imagePublicID = State(initialValue: uiModel.imagePublicID)
    }
}

#if DEBUG
struct ChatSendCellView_Previews: PreviewProvider {
    
    struct ChatSendCellViewDemo: View {
        
        var body: some View {
            ChatSendCellView(
                uiModel: ChatPreviewData.previewDataSendCell
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ChatSendCellViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
#endif
