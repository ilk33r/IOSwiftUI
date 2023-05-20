//
//  ChatInboxItemView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import IOSwiftUICommon
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

struct ChatInboxItemView: View {
    
    // MARK: - Defs
    
    typealias ClickHandler = (_ index: Int) -> Void
    
    // MARK: - Privates
    
    private let buttonDeleteWidth: CGFloat = 88
    private let uiModel: ChatInboxUIModel
    private let clickHandler: ClickHandler?
    private let deleteHandler: ClickHandler?
    
    @State private var profilePicturePublicId: String?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            IOSwipeActionView(
                buttonAreaWidth: 88,
                itemHeight: 88
            ) {
                HStack(alignment: .top) {
                    ProfilePictureImageView(
                        imagePublicID: $profilePicturePublicId
                    )
                    .frame(width: 64, height: 64, alignment: .top)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(uiModel.nameSurname)
                            .font(type: .bold(13))
                            .foregroundColor(.black)
                        Text(uiModel.lastMessage)
                            .lineLimit(2)
                            .font(type: .regular(13))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 1)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .frame(height: 72, alignment: .top)
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .background(Color.white)
            } _: {
                HStack(alignment: .top) {
                    Spacer()
                    IOButton {
                        ZStack {
                            Color.colorChatLastMessage
                                .cornerRadius(6)
                            Text(type: .buttonDelete)
                                .padding([.top, .bottom], 19)
                                .padding([.leading, .trailing], 12)
                                .font(type: .black(13))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .setClick {
                        deleteHandler?(uiModel.index)
                    }
                    .frame(width: 72, height: 62)
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
            }

            Rectangle()
                .fill(Color.colorPassthrought)
                .frame(height: 1)
        }
        .setClick {
            clickHandler?(uiModel.index)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        uiModel: ChatInboxUIModel,
        clickHandler: ClickHandler?,
        deleteHandler: ClickHandler?
    ) {
        self.uiModel = uiModel
        self.clickHandler = clickHandler
        self.deleteHandler = deleteHandler
        self._profilePicturePublicId = State(initialValue: uiModel.profilePicturePublicId)
    }
}

#if DEBUG
struct ChatInboxItemView_Previews: PreviewProvider {
    
    struct ChatInboxItemViewDemo: View {
        
        var body: some View {
            ChatInboxItemView(
                uiModel: ChatInboxPreviewData.previewDataItem,
                clickHandler: nil,
                deleteHandler: nil
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ChatInboxItemViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
#endif
