//
//  ProfilePictureImageView.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import SwiftUI

public struct ProfilePictureImageView: View {
    
    // MARK: - Privates
    
    @Binding private var imagePublicID: String?
    
    // MARK: - Body
    
    @ViewBuilder
    public var body: some View {
        if
            let profilePicturePublicId = imagePublicID,
            !profilePicturePublicId.isEmpty {
            Image()
                .from(publicId: _imagePublicID)
        } else {
            Image(systemName: "person.crop.circle")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        imagePublicID: Binding<String?>
    ) {
        self._imagePublicID = imagePublicID
    }
}

#if DEBUG
struct ProvilePictureImageView_Previews: PreviewProvider {
    
    struct ProvilePictureImageViewDemo: View {
        
        var body: some View {
            ProfilePictureImageView(
                imagePublicID: Binding.constant("")
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ProvilePictureImageViewDemo()
    }
}
#endif
