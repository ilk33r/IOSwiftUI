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
    
    // MARK: - Generics
    
    public typealias Presenter = StoriesPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: StoriesPresenter
    @StateObject public var navigationState = StoriesNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var currentPage = 0
    
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
                ) { item in
                    StoryItemView(
                        images: item.images,
                        isPresented: presenter.interactor.entity.isPresented
                    )
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
                .zIndex(20)
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
        .onChange(of: currentPage, perform: { value in
            IOLogger.debug("Page changed \(value)")
        })
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
