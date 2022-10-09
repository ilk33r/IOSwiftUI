// 
//  DiscoverView.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

struct DiscoverView: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = DiscoverPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: DiscoverPresenter
    @StateObject public var navigationState = DiscoverNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                PositionIndicator(type: .moving)
                LazyVStack {
                    ForEach(presenter.images) { item in
                        DiscoverCellView(uiModel: item, width: proxy.size.width)
                    }
                }
            }
            .background(PositionIndicator(type: .fixed))
            .onPreferenceChange(PositionPreferenceKey.self) { value in
                IOLogger.verbose("Position changed \(value)")
            }
            
            Color.white
                .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                .ignoresSafeArea()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Discover")
        .navigationWireframe(wireframeView: {
            DiscoverNavigationWireframe(navigationState: navigationState)
        })
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.loadImages()
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(entity: DiscoverEntity())
    }
}
