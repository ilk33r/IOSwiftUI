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
            Text(uiModel?.locationName ?? "")
                .font(type: .black(13))
                .padding(.top, 0)
                .padding(.bottom, 0)
            if uiModel?.isOwnProfile ?? false {
                PrimaryButton(.profileButtonFriends)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .setClick {
                        clickHandler?(.friends)
                    }
                SecondaryButton(.profileButtonSettings)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .setClick {
                        clickHandler?(.settings)
                    }
            } else {
                if uiModel?.isFollowing ?? false {
                    PrimaryButton(.profileButtonFollow.format(uiModel?.name ?? ""))
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .setClick {
                            clickHandler?(.follow)
                        }
                } else {
                    PrimaryButton(.profileButtonUnfollow.format(uiModel?.name ?? ""))
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .setClick {
                            clickHandler?(.unfollow)
                        }
                }
                SecondaryButton(.profileButtonMessage)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .setClick {
                        clickHandler?(.message)
                    }
            }
        }
    }
    
    init(
        uiModel: ProfileUIModel?,
        clickHandler: ClickHandler?
    ) {
        self.uiModel = uiModel
        self.clickHandler = clickHandler
        
        if let profilePicturePublicId = uiModel?.profilePicturePublicId {
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
        ProfileHeaderView(uiModel: nil, clickHandler: nil)
    }
}