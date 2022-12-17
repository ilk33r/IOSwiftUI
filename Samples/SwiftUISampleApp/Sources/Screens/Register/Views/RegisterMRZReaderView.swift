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
import IOSwiftUISupportVisionDetectText

public struct RegisterMRZReaderView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = RegisterMRZReaderPresenter
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterMRZReaderPresenter
    @StateObject public var navigationState = RegisterMRZReaderNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOVisionDetectTextView { texts in
                    presenter.parseMRZ(detectedTexts: texts)
                } errorHandler: { error in
                    presenter.update(cameraError: error)
                }
                .frame(width: proxy.size.width, height: proxy.size.height + proxy.safeAreaInsets.bottom + proxy.safeAreaInsets.top)
                .ignoresSafeArea()
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                EmptyView()
            }
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
