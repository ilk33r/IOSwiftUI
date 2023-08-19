// 
//  StoriesView.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.07.2023.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct StoriesView: IOController {
    
    // MARK: - Constants
    
    private let distanceForDismiss: CGFloat = 220
    
    // MARK: - Generics
    
    public typealias Presenter = StoriesPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: StoriesPresenter
    @StateObject public var navigationState = StoriesNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var currentPage = 0
    @State private var offsetY: CGFloat = 0
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Color.black
                    .ignoresSafeArea()
                    .zIndex(10)
                
                IOStoryScrollView(
                    items: presenter.stories,
                    currentPage: $currentPage
                ) { page, item in
                    StoryItemView(
                        images: item.images,
                        pageNumber: page,
                        totalPage: presenter.stories.count,
                        currentPage: $currentPage,
                        isPresented: presenter.interactor.entity.isPresented
                    )
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
                .zIndex(20)
                .offset(y: offsetY)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let newOffset = gesture.translation.height
                            if newOffset < 0 {
                                return
                            }
                            
                            offsetY = newOffset
                        }
                        .onEnded { gesture in
                            let locationDiff = gesture.location.y - gesture.startLocation.y
                            if locationDiff > distanceForDismiss {
                                presenter.interactor.entity.isPresented.wrappedValue = false
                            } else {
                                withAnimation(
                                    Animation
                                        .easeOut(duration: 0.15)
                                ) {
                                    offsetY = 0
                                }
                            }
                        }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                EmptyView()
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            StoriesNavigationWireframe(navigationState: navigationState)
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
    }
}

#if DEBUG
struct StoriesView_Previews: PreviewProvider {
    
    struct StoriesViewDemo: View {
        
        var body: some View {
            StoriesView(
                entity: StoriesEntity(
                    allStories: StoriesPreviewData.previewData,
                    isPresented: Binding.constant(true)
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return StoriesViewDemo()
    }
}
#endif
