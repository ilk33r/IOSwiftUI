// 
//  ProfileView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppComponents

struct ProfileView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ProfilePresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ProfilePresenter
    @StateObject public var navigationState = ProfileNavigationState()
    
    let galleryImages = [
        Image("pwGallery0"),
        Image("pwGallery1"),
        Image("pwGallery2"),
        Image("pwGallery3"),
        Image("pwGallery4"),
        Image("pwGallery5"),
        Image("pwGallery0"),
        Image("pwGallery1"),
        Image("pwGallery2"),
        Image("pwGallery3"),
        Image("pwGallery4"),
        Image("pwGallery5"),
        Image("pwGallery0"),
        Image("pwGallery1"),
        Image("pwGallery2"),
        Image("pwGallery3"),
        Image("pwGallery4"),
        Image("pwGallery5")
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            ProfileHeaderView()
                .padding(.top, 32)
            GalleryView(galleryImages: galleryImages)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .controllerWireframe {
            ProfileNavigationWireframe(navigationState: navigationState)
        }
        .navigationBarHidden(true)
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
