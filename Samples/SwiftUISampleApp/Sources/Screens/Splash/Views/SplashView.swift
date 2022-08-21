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
    
    // MARK: - Properties
    
    public var presenter: SplashPresenter
    
    @State private var isShowingRegisterPage = false
    
    public var body: some View {
        NavigationView {
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
    //            Spacer()
    //                .padding(.bottom, 92)
                HStack(spacing: 9) {
                    SecondaryButton(.splashButtonLogInUppercased)
                    NavigationLink(destination: RegisterView(), isActive: $isShowingRegisterPage) {
                        PrimaryButton(.splashButtonRegisterUppercased)
                            .setClick {
                                self.isShowingRegisterPage = true
                            }
                    }
                }
                .background(.white)
                .frame(height: 92)
            }
            .edgesIgnoringSafeArea([.top])
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(presenter: SplashPresenter())
    }
}
