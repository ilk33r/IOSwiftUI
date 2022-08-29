// 
//  PhotoGalleryView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIComponents
import IOSwiftUIPresentation
import SwiftUI

struct PhotoGalleryView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = PhotoGalleryPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: PhotoGalleryPresenter
    @StateObject public var navigationState = PhotoGalleryNavigationState()
    
    @Binding private var isPresented: Bool
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOPageView {
                    LazyHStack(spacing: 0) {
                        ForEach(presenter.imagesUIModel) { image in
                            image.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(
                                    width: proxy.size.width,
                                    height: proxy.size.height,
                                    alignment: .top
                                )
                                .contentShape(RoundedRectangle(cornerRadius: 2))
                                .clipped()
                        }
                    }
                }
                .zIndex(20)
                Color.black
                    .ignoresSafeArea()
                    .zIndex(10)
                ZStack(alignment: .topTrailing) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 18, height: 18)
                    }
                    .frame(
                        width: 40,
                        height: 40,
                        alignment: .topTrailing
                    )
                    .padding([.top, .trailing], 24)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .zIndex(30)
            }
            .frame(
                width: proxy.size.width,
                height: proxy.size.height,
                alignment: .top
            )
        }
        .controllerWireframe {
            PhotoGalleryNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            presenter.getImages()
        }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
        self._isPresented = Binding.constant(true)
    }
    
    init(isPresented: Binding<Bool>, entity: PhotoGalleryEntity) {
        let presenter = PhotoGalleryPresenter()
        presenter._initializaPresenterable(entity: entity)
        self.presenter = presenter
        
        self._isPresented = isPresented
    }
}

struct PhotoGalleryView_Previews: PreviewProvider {
    static var previews: some View {
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
        
        PhotoGalleryView(
            entity: PhotoGalleryEntity(images: galleryImages)
        )
    }
}
