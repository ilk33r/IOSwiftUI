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
    
    @IOInject private var bottomSheetPresenter: IOBottomSheetPresenter
    @IOInject private var thread: IOThread
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: RegisterMRZReaderPresenter
    @StateObject public var navigationState = RegisterMRZReaderNavigationState()
    
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    @State private var isFlashEnabled = false
    
    // MARK: - Body
    
    public var body: some View {
        EmptyView()
        /*
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                IOVisionDetectTextView(
                    isRunning: $presenter.isCameraRunning,
                    isFlashEnabled: $isFlashEnabled) { texts in
                    presenter.parseMRZ(detectedTexts: texts)
                } errorHandler: { error in
                    presenter.update(cameraError: error)
                }
                .frame(width: proxy.size.width, height: proxy.size.height + proxy.safeAreaInsets.bottom + proxy.safeAreaInsets.top)
                .ignoresSafeArea()
                
                IOVisionIdentityShape()
                    .stroke(Color.colorPlaceholder)
                    .padding(64)
                    .frame(width: proxy.size.width, height: proxy.size.width * 1.4)
                    .offset(y: proxy.safeAreaInsets.top)
                
                RegisterMRZFlashButton(
                    isFlashEnabled: $isFlashEnabled
                )
                .offset(
                    x: (proxy.size.width / 2) - 56,
                    y: proxy.size.height - 96
                )
                
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    .registerTitleMRZ,
                    iconName: "lanyardcard",
                    width: 22,
                    height: 30
                )
            }
        }
        .controllerWireframe {
            RegisterMRZReaderNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
        }
        .onReceive(presenter.$showNFCErrorBottomSheet) { output in
            if output {
                presenter.showNFCErrorBottomSheet = false
                showNFCBottomSheet()
            }
        }
        .onReceive(presenter.$navigateToBack) { output in
            if output {
                presentationMode.wrappedValue.dismiss()
            }
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    // MARK: - Helper Methods
    
    private func showNFCBottomSheet() {
        bottomSheetPresenter.show {
            IOBottomSheetView {
                VStack {
                    Image(systemName: "lanyardcard")
                        .resizable()
                        .frame(width: 36, height: 50)
                    Text(type: .registerNFCError5)
                        .font(type: .regular(14))
                        .lineLimit(0)
                        .padding(.top, 8)
                    PrimaryButton(.registerButtonScan)
                        .setClick {
                            bottomSheetPresenter.dismiss()
                            presenter.rescanID()
                        }
                        .padding(16)
                }
            }
        }
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
