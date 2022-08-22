// 
//  LoginView.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI

struct LoginView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = LoginPresenter
    typealias Wireframe = LoginNavigationWireframe
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: LoginPresenter
    @StateObject public var navigationState = LoginNavigationState()
    
    var controllerBody: some View {
        Text("Login")
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
