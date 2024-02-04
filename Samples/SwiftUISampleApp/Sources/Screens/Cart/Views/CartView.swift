// 
//  CartView.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.02.2024.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

public struct CartView: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = CartPresenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: CartPresenter
    @StateObject public var navigationState = CartNavigationState()
    
    @EnvironmentObject private var appEnvironment: SampleAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Text("Cart")
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                NavBarTitleView(
                    IOLocalizationType.title.format("2").localized,
                    iconName: "cart",
                    hasBackButton: true
                )
            }
        }
        .navigationWireframe(hasNavigationView: false) {
            CartNavigationWireframe(navigationState: navigationState)
        }
        .onAppear {
            if isPreviewMode {
                return
            }
            
            presenter.environment = _appEnvironment
            presenter.navigationState = _navigationState
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}

#if DEBUG
struct CartView_Previews: PreviewProvider {
    
    struct CartViewDemo: View {
        
        var body: some View {
            CartView(
                entity: CartEntity()
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return CartViewDemo()
    }
}
#endif
