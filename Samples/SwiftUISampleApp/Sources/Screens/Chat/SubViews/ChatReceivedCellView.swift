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
    
    private let uiModel: ChatItemUIModel
    
    @State private var imagePublicID: String?
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top) {
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
        self._imagePublicID = State(initialValue: uiModel.imagePublicID)
    }
}

#if DEBUG
struct ChatReceivedCellView_Previews: PreviewProvider {
    
    struct ChatReceivedCellViewDemo: View {
        
        var body: some View {
            ChatReceivedCellView(
                uiModel: ChatPreviewData.previewDataReceivedCell
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ChatReceivedCellViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
#endif
