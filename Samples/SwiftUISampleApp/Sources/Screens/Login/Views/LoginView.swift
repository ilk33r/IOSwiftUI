// 
//  LoginView.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import IOSwiftUIComponents
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppComponents

struct LoginView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = LoginPresenter
    typealias Wireframe = LoginNavigationWireframe
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: LoginPresenter
    @StateObject public var navigationState = LoginNavigationState()
    
    // MARK: - States
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    
    // MARK: - Body
    
    var controllerBody: some View {
        IOFormGroup(.commonDone, handler: {

        }, content: {
            VStack(alignment: .leading) {
                Text(type: .loginTitle)
                    .foregroundColor(.black)
                    .font(type: .regular(36))
                    .multilineTextAlignment(.leading)
                FloatingTextField(
                    .registerInputEmailAddress,
                    text: $emailText
                )
                .keyboardType(.emailAddress)
                .padding(.top, 32)
                FloatingTextField(
                    .loginInputPassword,
                    text: $passwordText
                )
                .padding(.top, 16)
                PrimaryButton(.commonNextUppercased)
                    .padding(.top, 16)
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        })
    }
    
    var wireframeView: LoginNavigationWireframe {
        LoginNavigationWireframe(navigationState: navigationState)
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(entity: LoginEntity())
    }
}
