//
//  ChatInboxItemView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI
import IOSwiftUICommon

struct ChatInboxItemView: View {
    
    typealias ClickHandler = (_ index: Int) -> Void
    
    private let uiModel: ChatInboxUIModel
    private let clickHandler: ClickHandler?
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image()
                    .from(publicId: uiModel.profilePicturePublicId)
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(uiModel.nameSurname)
                        .font(type: .bold(13))
                        .foregroundColor(.black)
                    Text(uiModel.lastMessage)
                        .lineLimit(3)
                        .font(type: .regular(13))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 2)
                }
                .padding(.leading, 16)
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.top, 16)
            .padding(.bottom, 16)
            Rectangle()
                .fill(Color.colorPassthrought)
                .frame(height: 1)
        }
        .onTapGesture {
            clickHandler?(uiModel.index)
        }
    }
    
    init(
        uiModel: ChatInboxUIModel,
        clickHandler: ClickHandler?
    ) {
        self.uiModel = uiModel
        self.clickHandler = clickHandler
    }
}

struct ChatInboxItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChatInboxItemView(
            uiModel: ChatInboxUIModel(
                index: 0,
                profilePicturePublicId: "pwProfilePicture",
                nameSurname: "İlker Özcan",
                lastMessage: "Wanted to ask if you’re available for a portrait shoot next week."
            ),
            clickHandler: nil
        )
        .previewLayout(.sizeThatFits)
    }
}
