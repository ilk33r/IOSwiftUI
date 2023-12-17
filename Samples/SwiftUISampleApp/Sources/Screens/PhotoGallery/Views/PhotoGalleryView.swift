// 
//  PhotoGalleryView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct PhotoGalleryView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = PhotoGalleryPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: PhotoGalleryPresenter
    @StateObject public var navigationState = PhotoGalleryNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @Binding private var isPresented: Bool
    @State private var currentPage = 0
    @State private var contentSize = CGFloat.zero
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOPageView(
                    initialPage: presenter.interactor.entity.selectedIndex,
                    currentPage: $currentPage,
                    rootViewWidth: $contentSize
                ) {
                    LazyHStack(spacing: 0) {
                        ForEach(presenter.imagesUIModel) { image in
                            Image()
                                .from(publicId: image.imagePublicId)
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
                .sizePreference()
                
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                EmptyView()
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            PhotoGalleryNavigationWireframe(navigationState: navigationState)
        }
        .onPreferenceChange(IOSizePreferenceKey.self) { value in
            contentSize = value.width * CGFloat(presenter.interactor.entity.imagePublicIds.count)
        }
        .onAppear {
            if isPreviewMode {
                presenter.prepare()
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
            presenter.prepare()
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
        self._isPresented = presenter.interactor.entity.isPresented
    }
}

#if DEBUG
struct PhotoGalleryView_Previews: PreviewProvider {
    
    struct PhotoGalleryViewDemo: View {
        
        var body: some View {
            PhotoGalleryView(
                entity: PhotoGalleryEntity(
                    imagePublicIds: PhotoGalleryPreviewData.previewData,
                    isPresented: Binding.constant(false),
                    selectedIndex: 0
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return PhotoGalleryViewDemo()
    }
}
#endif
