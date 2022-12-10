//
//  ProvilePictureImageView.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import SwiftUI

public struct ProvilePictureImageView: View {
    
    // MARK: - Privates
    
    private let imagePublicID: String?
    
    // MARK: - Body
    
    @ViewBuilder
    public var body: some View {
        if
            let profilePicturePublicId = imagePublicID,
            !profilePicturePublicId.isEmpty {
            Image()
                .from(publicId: profilePicturePublicId)
        } else {
            Image(systemName: "person.crop.circle")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(imagePublicID: String?) {
        self.imagePublicID = imagePublicID
    }
}

#if DEBUG
struct ProvilePictureImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return ProvilePictureImageView(imagePublicID: "pwChatAvatar")
    }
}
#endif
