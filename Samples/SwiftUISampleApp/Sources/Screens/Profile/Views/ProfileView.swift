// 
//  ProfileView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI

struct ProfileView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ProfilePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ProfilePresenter
    @StateObject public var navigationState = ProfileNavigationState()
    
    var body: some View {
        ZStack(alignment: .top) {
            ProfileHeaderView()
                .padding(.top, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .controllerWireframe {
            ProfileNavigationWireframe(navigationState: navigationState)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(entity: ProfileEntity())
    }
}
