// 
//  SearchView.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct SearchView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = SearchPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: SearchPresenter
    @StateObject public var navigationState = SearchNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .navigationBar {
                Text("Navbar")
            }
        }
        .navigationWireframe {
            SearchNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if !isPreviewMode {
                presenter.environment = _appEnvironment
                presenter.navigationState = _navigationState
            }
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct SearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return SearchView(entity: SearchEntity())
    }
}
