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
    
    @State private var profilePicturePublicId: String?
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .top) {
                ProfilePictureImageView(
                    imagePublicID: $profilePicturePublicId
                )
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
        self._profilePicturePublicId = State(initialValue: uiModel.profilePicturePublicId)
    }
}

#if DEBUG
struct FriendCellView_Previews: PreviewProvider {
    
    struct FriendCellViewDemo: View {
        
        var body: some View {
            FriendCellView(
                uiModel: FriendsPreviewData.previewDataItem,
                clickHandler: { _ in
                }
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return FriendCellViewDemo()
            .previewLayout(.fixed(width: 320, height: 88))
    }
}
#endif
