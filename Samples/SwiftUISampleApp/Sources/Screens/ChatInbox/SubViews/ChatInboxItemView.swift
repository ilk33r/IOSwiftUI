//
//  ChatInboxItemView.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import SwiftUI
import IOSwiftUICommon
import IOSwiftUIPresentation

struct ChatInboxItemView: View {
    
    // MARK: - Defs
    
    typealias ClickHandler = (_ index: Int) -> Void
    
    // MARK: - Privates
    
    private let buttonDeleteWidth: CGFloat = 88
    private let uiModel: ChatInboxUIModel
    private let clickHandler: ClickHandler?
    private let deleteHandler: ClickHandler?
    
    @State private var deleteButtonIsHidden = true
    @State private var offset: CGSize = .zero
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                HStack(alignment: .top) {
                    Spacer()
                    IOButton {
                        ZStack {
                            Color.colorChatLastMessage
                                .cornerRadius(6)
                            Text(type: .chatInboxButtonDelete)
                                .padding([.top, .bottom], 19)
                                .padding([.leading, .trailing], 12)
                                .font(type: .black(13))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .setClick {
                        deleteHandler?(0)
                    }
                    .frame(width: 72, height: 62)
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                .zIndex(1)
                .hidden(isHidden: $deleteButtonIsHidden)
                HStack(alignment: .top) {
                    Image()
                        .from(publicId: uiModel.profilePicturePublicId)
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
                .offset(x: offset.width, y: 0)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if deleteButtonIsHidden {
                                deleteButtonIsHidden = false
                            }
                            
                            let newOffset = gesture.translation.width
                            if newOffset <= 0 && newOffset >= -buttonDeleteWidth {
                                offset.width = newOffset
                            } else if newOffset <= 0 {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset.width = -buttonDeleteWidth
                                }
                            } else {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset = .zero
                                    deleteButtonIsHidden = true
                                }
                            }
                        }
                        .onEnded { _ in
                            if offset.width <= -buttonDeleteWidth {
                                offset.width = -buttonDeleteWidth
                            } else if offset.width < (-buttonDeleteWidth) / 2 {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset.width = -buttonDeleteWidth
                                }
                            } else {
                                withAnimation(
                                    Animation
                                        .interactiveSpring()
                                ) {
                                    offset = .zero
                                    deleteButtonIsHidden = true
                                }
                            }
                        }
                )
                .zIndex(2)
            }
            .frame(height: 88)
            Rectangle()
                .fill(Color.colorPassthrought)
                .frame(height: 1)
        }
        .setClick {
            clickHandler?(uiModel.index)
        }
    }
    
    init(
        uiModel: ChatInboxUIModel,
        clickHandler: ClickHandler?,
        deleteHandler: ClickHandler?
    ) {
        self.uiModel = uiModel
        self.clickHandler = clickHandler
        self.deleteHandler = deleteHandler
    }
}

struct ChatInboxItemView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        return ChatInboxItemView(
            uiModel: ChatInboxUIModel(
                index: 0,
                profilePicturePublicId: "pwProfilePicture",
                nameSurname: "İlker Özcan",
                lastMessage: "Wanted to ask if you’re available for a portrait shoot next week."
            ),
            clickHandler: nil,
            deleteHandler: nil
        )
        .previewLayout(.sizeThatFits)
    }
}
