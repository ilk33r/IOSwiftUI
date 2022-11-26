//
//  ProfileHeaderView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppPresentation

struct ProfileHeaderView: View {
    
    // MARK: - Defs
    
    enum ButtonTypes {
        case friends
        case settings
        case follow
        case unfollow
        case message
        case location
    }
    
    typealias ClickHandler = (_ buttonType: ButtonTypes) -> Void
    
    // MARK: - Privates
    
    private let clickHandler: ClickHandler?
    private let uiModel: ProfileUIModel?
    private let profilePictureImage: AnyView
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            profilePictureImage
                .frame(width: 128, height: 128)
                .clipShape(Circle())
            Text(uiModel?.nameSurname ?? "")
                .font(type: .regular(36))
                .padding(.top, 16)
                .padding(.bottom, 4)
            Button(uiModel?.locationName ?? "Location") {
                clickHandler?(.location)
            }
            .font(type: .black(13))
            .foregroundColor(.black)
            .padding(.top, 0)
            .padding(.bottom, 0)
            .frame(minHeight: 18)
            if uiModel?.isOwnProfile ?? false {
                PrimaryButton(.profileButtonFriends)
                    .setClick {
                        clickHandler?(.friends)
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                SecondaryButton(.profileButtonSettings)
                    .setClick {
                        clickHandler?(.settings)
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            } else {
                if uiModel?.isFollowing ?? false {
                    PrimaryButton(.profileButtonFollow.format(uiModel?.name ?? ""))
                        .setClick {
                            clickHandler?(.follow)
                        }
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                } else {
                    PrimaryButton(.profileButtonUnfollow.format(uiModel?.name ?? ""))
                        .setClick {
                            clickHandler?(.unfollow)
                        }
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                }
                SecondaryButton(.profileButtonMessage)
                    .setClick {
                        clickHandler?(.message)
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            }
        }
    }
    
    init(
        uiModel: ProfileUIModel?,
        clickHandler: ClickHandler?
    ) {
        self.uiModel = uiModel
        self.clickHandler = clickHandler
        
        if let profilePicturePublicId = uiModel?.profilePicturePublicId, !profilePicturePublicId.isEmpty {
            let profilePictureImage = Image()
                .from(publicId: profilePicturePublicId)
            self.profilePictureImage = AnyView(profilePictureImage)
        } else {
            let profilePictureImage = Image(systemName: "person.crop.circle")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fill)
            self.profilePictureImage = AnyView(profilePictureImage)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return ProfileHeaderView(uiModel: nil, clickHandler: nil)
    }
}
