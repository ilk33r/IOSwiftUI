// 
//  RegisterNFCReaderViewView.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct RegisterNFCReaderViewView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterNFCReaderViewPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterNFCReaderViewPresenter
    @StateObject public var navigationState = RegisterNFCReaderViewNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack {
                    Image(systemName: "lanyardcard")
                        .resizable()
                        .frame(width: 36, height: 50)
                    Text(type: .registerNfcInfo1)
                        .font(type: .regular(14))
                        .lineLimit(0)
                        .padding(.top, 8)
                    PrimaryButton(.registerButtonScan)
                        .setClick {
                        }
                        .padding(16)
                    Spacer()
                }
                .padding(.top, 64)
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .registerTitleNFC,
                    iconName: "lanyardcard",
                    width: 22,
                    height: 30
                )
            }
        }
        .controllerWireframe {
            RegisterNFCReaderViewNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct RegisterNFCReaderViewView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return RegisterNFCReaderViewView(
            entity: RegisterNFCReaderViewEntity(
                birthDate: "801010",
                documentNumber: "12345678",
                expireDate: "301010",
                identityNumber: "12345678912"
            )
        )
    }
}
#endif
