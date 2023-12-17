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
    
    private let headerPaddingTop: CGFloat = 24
    private let clickHandler: ClickHandler?
    
    @Binding private var uiModel: ProfileUIModel?
    @Binding private var scrollOffset: CGFloat
    @State private var headerHeight: CGFloat = 0
    @State private var profilePicturePublicId: String?
    @State private var locationButtonYPosition: CGFloat = 0
    @State private var primaryButtonYPosition: CGFloat = 0
    @State private var secondaryButtonYPosition: CGFloat = 0
    @Namespace private var headerSpace
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ProfilePictureImageView(
                imagePublicID: $profilePicturePublicId
            )
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
            .allowsHitTesting(headerHeight - scrollOffset >= locationButtonYPosition)
            .padding(.top, 0)
            .padding(.bottom, 0)
            .frame(minHeight: 18)
            .background(GeometryReader { geo in
                Color.clear
                    .onAppear {
                        let frame = geo.frame(in: .named(headerSpace))
                        self.locationButtonYPosition = frame.origin.y + frame.size.height
                    }
            })
            
            if uiModel?.isOwnProfile ?? false {
                PrimaryButton(.buttonFriends)
                    .setClick {
                        clickHandler?(.friends)
                    }
                    .allowsHitTesting(headerHeight - scrollOffset >= primaryButtonYPosition)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .background(GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                let frame = geo.frame(in: .named(headerSpace))
                                self.primaryButtonYPosition = frame.origin.y + frame.size.height
                            }
                    })
                
                SecondaryButton(.buttonSettings)
                    .setClick {
                        clickHandler?(.settings)
                    }
                    .allowsHitTesting(headerHeight - scrollOffset >= secondaryButtonYPosition)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .background(GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                let frame = geo.frame(in: .named(headerSpace))
                                self.secondaryButtonYPosition = frame.origin.y + frame.size.height
                            }
                    })
            } else {
                if uiModel?.isFollowing ?? false {
                    PrimaryButton(.buttonUnfollow.format(uiModel?.name ?? ""))
                        .setClick {
                            clickHandler?(.unfollow)
                        }
                        .allowsHitTesting(headerHeight - scrollOffset >= primaryButtonYPosition)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .background(GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    let frame = geo.frame(in: .named(headerSpace))
                                    self.primaryButtonYPosition = frame.origin.y + frame.size.height
                                }
                        })
                } else {
                    PrimaryButton(.buttonFollow.format(uiModel?.name ?? ""))
                        .setClick {
                            clickHandler?(.follow)
                        }
                        .allowsHitTesting(headerHeight - scrollOffset >= primaryButtonYPosition)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .background(GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    let frame = geo.frame(in: .named(headerSpace))
                                    self.primaryButtonYPosition = frame.origin.y + frame.size.height
                                }
                        })
                }
                SecondaryButton(.buttonMessage)
                    .setClick {
                        clickHandler?(.message)
                    }
                    .allowsHitTesting(headerHeight - scrollOffset >= secondaryButtonYPosition)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .background(GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                let frame = geo.frame(in: .named(headerSpace))
                                self.secondaryButtonYPosition = frame.origin.y + frame.size.height
                            }
                    })
            }
        }
        .background(GeometryReader { geo in
            Color.clear
                .onAppear {
                    let size = geo.frame(in: .named(headerSpace)).size
                    self.headerHeight = size.height + 34
                }
        })
        .coordinateSpace(name: headerSpace)
        .onChange(of: uiModel) { newValue in
            profilePicturePublicId = newValue?.profilePicturePublicId
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        uiModel: Binding<ProfileUIModel?>,
        scrollOffset: Binding<CGFloat>,
        clickHandler: ClickHandler?
    ) {
        self._uiModel = uiModel
        self._scrollOffset = scrollOffset
        self._profilePicturePublicId = State(initialValue: uiModel.wrappedValue?.profilePicturePublicId)
        self.clickHandler = clickHandler
    }
}

#if DEBUG
struct ProfileHeaderView_Previews: PreviewProvider {
    
    struct ProfileHeaderViewDemo: View {
        
        var body: some View {
            ProfileHeaderView(
                uiModel: Binding.constant(nil),
                scrollOffset: Binding.constant(0),
                clickHandler: nil
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return ProfileHeaderViewDemo()
    }
}
#endif
