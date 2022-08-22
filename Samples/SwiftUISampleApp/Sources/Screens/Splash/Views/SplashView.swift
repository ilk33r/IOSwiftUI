//
//  SplashView.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppComponents

public struct SplashView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SplashPresenter
    public typealias Wireframe = SplashNavigationWireframe
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SplashPresenter
    @StateObject public var navigationState = SplashNavigationState()
    
    public var controllerBody: some View {
        VStack {
            ZStack {
                Image.bgSplash
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                HStack(spacing: 20) {
                    Image.icnLogo
                        .resizable()
                        .frame(width: 38, height: 38)
                    Text(type: .commonAppName)
                        .font(type: .regular(48))
                }
            }
            HStack(spacing: 9) {
                SecondaryButton(.splashButtonLogInUppercased)
                    .frame(minWidth: 0, maxWidth: .infinity)
                PrimaryButton(.splashButtonRegisterUppercased)
                    .setClick {
                        self.navigationState.navigateToRegister = true
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.white)
            .frame(height: 92)
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
        .edgesIgnoringSafeArea([.top])
    }
    
    public var wireframeView: SplashNavigationWireframe {
        SplashNavigationWireframe(navigationState: navigationState)
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
