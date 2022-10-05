//
//  ProfileHeaderView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppComponents

struct ProfileHeaderView: View {
    
    private let nameAndSurname: String
    private let locationName: String
    private let profilePictureImage: AnyView
    
    var body: some View {
        VStack {
            profilePictureImage
                .frame(width: 128, height: 128)
                .clipShape(Circle())
            Text(nameAndSurname)
                .font(type: .regular(36))
                .padding(.top, 16)
                .padding(.bottom, 4)
            Text(locationName)
                .font(type: .black(13))
                .padding(.top, 0)
                .padding(.bottom, 0)
            PrimaryButton(.profileButtonFollow)
                .padding(.top, 16)
                .padding(.leading, 16)
                .padding(.trailing, 16)
            SecondaryButton(.profileButtonMessage)
                .padding(.top, 16)
                .padding(.leading, 16)
                .padding(.trailing, 16)
        }
    }
    
    init(member: MemberModel?) {
        let name = member?.name ?? ""
        let surname = member?.surname ?? ""
        
        self.nameAndSurname = String(format: "%@ %@", name, surname)
        self.locationName = member?.locationName ?? ""
        
        if let profilePicturePublicId = member?.profilePicturePublicId {
            let profilePictureImage = Image()
                .from(publicId: profilePicturePublicId)
            self.profilePictureImage = AnyView(profilePictureImage)
        } else {
            let profilePictureImage = Image(systemName: "person.crop.circle")
                .renderingMode(.template)
            self.profilePictureImage = AnyView(profilePictureImage)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(member: nil)
    }
}
