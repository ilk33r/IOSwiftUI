//
//  ProfileHeaderView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI
import SwiftUISampleAppComponents

struct ProfileHeaderView: View {
    
    var body: some View {
        VStack {
            Image("pwProfilePicture")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 128, height: 128)
                .clipShape(Circle())
            Text("Jane Doe")
                .font(type: .regular(36))
                .padding(.top, 32)
//            Text("San francisco, ca")
//                .font(type: .black(13))
//                .padding(.top, 16)
//            PrimaryButton(.profileButtonFollow)
//                .padding(.top, 32)
//                .padding(.leading, 16)
//                .padding(.trailing, 16)
//            SecondaryButton(.profileButtonMessage)
//                .padding(.top, 16)
//                .padding(.leading, 16)
//                .padding(.trailing, 16)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
