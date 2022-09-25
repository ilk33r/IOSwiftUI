//
//  SplashView.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppComponents

public struct SplashView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SplashPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SplashPresenter
    @StateObject public var navigationState = SplashNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var buttonsIsHidden = true
    
    public var body: some View {
        VStack {
            ZStack {
                Image.bgSplash
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                HStack(spacing: 20) {
                    Image.icnLogo
                        .resizable()
                        .frame(width: 38, height: 38)
                    Text(type: .commonAppName)
                        .font(type: .regular(48))
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .clipped()
            HStack(alignment: .bottom, spacing: 9) {
                SecondaryButton(.splashButtonLogInUppercased)
                    .setClick({
                        self.navigationState.navigateToLogin = true
                    })
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .hidden(isHidden: $buttonsIsHidden)
                PrimaryButton(.splashButtonRegisterUppercased)
                    .setClick {
                        self.navigationState.navigateToRegister = true
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .hidden(isHidden: $buttonsIsHidden)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.white)
            .frame(height: 92)
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
        .edgesIgnoringSafeArea([.top])
        .navigationWireframe {
            SplashNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !self.isPreviewMode {
                self.presenter.environment = _appEnvironment
                self.presenter.interactor.handshake()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(entity: SplashEntity())
    }
}
