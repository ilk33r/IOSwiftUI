//
//  FriendCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import SwiftUI
import SwiftUISampleAppPresentation

struct FriendCellView: View {
    
    // MARK: - Defs
    
    typealias ClickHandler = (_ userName: String) -> Void
    
    // MARK: - Privates
    
    private let clickHandler: ClickHandler?
    private let uiModel: FriendUIModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .top) {
                ProfilePictureImageView(imagePublicID: uiModel.profilePicturePublicId)
                    .frame(width: 64, height: 64, alignment: .top)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(uiModel.userName)
                        .font(type: .bold(13))
                        .foregroundColor(.black)
                    Text(uiModel.userNameAndSurname)
                        .font(type: .regular(11))
                        .foregroundColor(.black)
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
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
        .setClick {
            clickHandler?(uiModel.userName)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        uiModel: FriendUIModel,
        clickHandler: ClickHandler?
    ) {
        self.clickHandler = clickHandler
        self.uiModel = uiModel
    }
}

#if DEBUG
struct FriendCellView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        return FriendCellView(
            uiModel: FriendUIModel(
                userName: "ilker0",
                userNameAndSurname: "??lker ??ZCAN",
                locationName: "Avc??lar, ??stanbul",
                locationLatitude: 0,
                locationLongitude: 0,
                profilePicturePublicId: "pwChatAvatar"
            ),
            clickHandler: { _ in
            }
        )
        .previewLayout(.fixed(width: 320, height: 88))
    }
}
#endif
