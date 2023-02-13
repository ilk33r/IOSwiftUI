// 
//  FriendsView.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared
import SwiftUISampleAppPresentation

public struct FriendsView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = FriendsPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: FriendsPresenter
    @StateObject public var navigationState = FriendsNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var tabControlPage = 0
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOTabControlView(
                    page: $tabControlPage,
                    tabControlHeight: 52,
                    tabTitles: [
                        .friendsTabFollowers.format(presenter.followersCount),
                        .friendsTabFollowing.format(presenter.followingsCount)
                    ]
                ) {
                    HStack {
                        ScrollView {
                            VStack {
                                ForEach(presenter.followers) { follower in
                                    FriendCellView(
                                        uiModel: follower
                                    ) { userName in
                                        presenter.navigate(toUser: userName)
                                    }
                                    .frame(
                                        width: proxy.size.width,
                                        height: 88
                                    )
                                }
                            }
                            .frame(
                                width: proxy.size.width
                            )
                        }
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height - 52,
                            alignment: .top
                        )
                        
                        ScrollView {
                            VStack {
                                ForEach(presenter.followings) { follower in
                                    FriendCellView(
                                        uiModel: follower
                                    ) { userName in
                                        presenter.navigate(toUser: userName)
                                    }
                                    .frame(
                                        width: proxy.size.width,
                                        height: 88
                                    )
                                }
                            }
                            .frame(
                                width: proxy.size.width
                            )
                        }
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height - 52,
                            alignment: .top
                        )
                    }
                }
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                HStack {
                    HStack {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .frame(width: 20, height: 14)
                            .padding(.trailing, 4)
                            .padding(.leading, -8)
                        Text(type: .friendsTitle)
                            .font(type: .medium(17))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.leading, 32)
                    .padding(.trailing, 32)
                    .frame(width: proxy.size.width - 108)
                    Button {
                        
                    } label: {
                        Image(systemName: "map")
                    }
                    .foregroundColor(.black)
                    .frame(width: 32)
                }
            }
        }
        .controllerWireframe {
            FriendsNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.interactor.getFriends()
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        prepare()
        let friend0 = MemberFriendModel()
        friend0.id = 0
        friend0.userName = "ilker0"
        friend0.userNameAndSurname = "İlker Özcan"
        friend0.locationName = "Avcılar İstanbul"
        
        let friends = MemberFriendsResponseModel()
        friends.followers = [
            friend0,
            friend0,
            friend0,
            friend0,
            friend0,
            friend0,
            friend0
        ]
        friends.followings = [
            friend0,
            friend0,
            friend0,
            friend0,
            friend0,
            friend0,
            friend0
        ]
        
        return FriendsView(
            entity: FriendsEntity(
                friends: friends
            )
        )
    }
}
#endif
