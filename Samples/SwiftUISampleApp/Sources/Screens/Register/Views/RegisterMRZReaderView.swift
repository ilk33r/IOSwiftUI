// 
//  RegisterMRZReaderView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation
import SwiftUISampleAppScreensShared

public struct RegisterMRZReaderView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterMRZReaderPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterMRZReaderPresenter
    @StateObject public var navigationState = RegisterMRZReaderNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        Text("RegisterMRZReader")
//      .navigationWireframe {
//          RegisterMRZReaderNavigationWireframe(navigationState: navigationState)
//      }
        .navigationBar {
            EmptyView()
        }
        .controllerWireframe {
            RegisterMRZReaderNavigationWireframe(navigationState: navigationState)
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

#if DEBUG
struct RegisterMRZReaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return RegisterMRZReaderView(entity: RegisterMRZReaderEntity())
    }
}
#endif
