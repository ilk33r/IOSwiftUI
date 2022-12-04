//
//  FriendCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import SwiftUI

struct FriendCellView: View {
    
    // MARK: - Privates
    
    private let uiModel: FriendUIModel
    
    // MARK: - Body
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: - Initialization Methods
    
    init(uiModel: FriendUIModel) {
        self.uiModel = uiModel
    }
}

struct FriendCellView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        return FriendCellView(
            uiModel: FriendUIModel(
                userName: "ilker0",
                userNameAndSurname: "İlker ÖZCAN",
                locationName: "Avcılar, İstanbul",
                locationLatitude: 0,
                locationLongitude: 0,
                profilePicturePublicId: "pwChatAvatar"
            )
        )
        .previewLayout(.fixed(width: 320, height: 90))
    }
}
