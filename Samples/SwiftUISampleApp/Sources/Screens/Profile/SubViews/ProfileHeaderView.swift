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
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ProfilePictureImageView(imagePublicID: uiModel?.profilePicturePublicId)
                .frame(width: 128, height: 128)
                .clipShape(Circle())
            Text(uiModel?.nameSurname ?? "")
                .font(type: .regular(36))
                .padding(.top, 16)
                .padding(.bottom, 4)
            Button(uiModel?.locationName ?? "") {
                clickHandler?(.location)
            }
            .font(type: .black(13))
            .foregroundColor(.black)
            .padding(.top, 0)
            .padding(.bottom, 0)
            .frame(minHeight: 18)
            if uiModel?.isOwnProfile ?? false {
                PrimaryButton(.buttonFriends)
                    .setClick {
                        clickHandler?(.friends)
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                SecondaryButton(.buttonSettings)
                    .setClick {
                        clickHandler?(.settings)
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            } else {
                if uiModel?.isFollowing ?? false {
                    PrimaryButton(.buttonUnfollow.format(uiModel?.name ?? ""))
                        .setClick {
                            clickHandler?(.unfollow)
                        }
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                } else {
                    PrimaryButton(.buttonFollow.format(uiModel?.name ?? ""))
                        .setClick {
                            clickHandler?(.follow)
                        }
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                }
                SecondaryButton(.buttonMessage)
                    .setClick {
                        clickHandler?(.message)
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        uiModel: ProfileUIModel?,
        clickHandler: ClickHandler?
    ) {
        self.uiModel = uiModel
        self.clickHandler = clickHandler
    }
}

#if DEBUG
struct ProfileHeaderView_Previews: PreviewProvider {
    
    struct ProfileHeaderViewDemo: View {
        
        var body: some View {
            ProfileHeaderView(uiModel: nil, clickHandler: nil)
        }
    }
    
    static var previews: some View {
        prepare()
        return ProfileHeaderViewDemo()
    }
}
#endif
