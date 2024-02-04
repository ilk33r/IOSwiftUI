// 
//  CartItemView.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.02.2024.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppScreensShared

struct CartItemView: View {
    
    // MARK: - Privates
    
    private let buttonDeleteWidth: CGFloat = 88
    private let uiModel: CartUIModel
//    private let deleteHandler: ClickHandler?
    
    @State private var imagePublicId: String?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            IOSwipeActionView(
                buttonAreaWidth: 88,
                itemHeight: 88
            ) {
                HStack(alignment: .top) {
                    Image()
                        .from(publicId: $imagePublicId)
                        .frame(width: 64, height: 64, alignment: .top)
                    
                    VStack(alignment: .leading) {
                        Text(uiModel.nameSurname)
                            .font(type: .bold(13))
                            .foregroundColor(.black)
                        Text(uiModel.userName)
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
                    
                    Text(uiModel.price)
                        .font(type: .bold(16))
                        .foregroundColor(.black)
                        .frame(height: 56, alignment: .center)
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
                            Text(type: .delete)
                                .padding([.top, .bottom], 19)
                                .padding([.leading, .trailing], 12)
                                .font(type: .black(13))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                    }
//                    .setClick {
//                        deleteHandler?(uiModel.index)
//                    }
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
//        .setClick {
//            clickHandler?(uiModel.index)
//        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        uiModel: CartUIModel
    ) {
        self.uiModel = uiModel
        self._imagePublicId = State(initialValue: uiModel.picturePublicId)
    }
}

#if DEBUG
struct CartItemView_Previews: PreviewProvider {
    
    struct CartItemViewDemo: View {
        
        var body: some View {
            CartItemView(
                uiModel: CartPreviewData.previewDataItem
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return CartItemViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
#endif
