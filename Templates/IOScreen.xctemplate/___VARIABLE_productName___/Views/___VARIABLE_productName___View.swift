// ___FILEHEADER___

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

public struct ___VARIABLE_productName___View: IOController {
    
    // MARK: - Generics
    
    public typealias Presenter = ___VARIABLE_productName___Presenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ___VARIABLE_productName___Presenter
    @StateObject public var navigationState = ___VARIABLE_productName___NavigationState()
    
    @EnvironmentObject private var appEnvironment: TAppEnvironment
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                    Text("___VARIABLE_productName___")
                Color.white
                    .frame(width: proxy.size.width, height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBar {
                EmptyView()
            }
        }
//      .navigationWireframe {
//          ___VARIABLE_productName___NavigationWireframe(navigationState: navigationState)
//      }
        .controllerWireframe {
            ___VARIABLE_productName___NavigationWireframe(navigationState: navigationState)
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
struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return ___VARIABLE_productName___View(entity: ___VARIABLE_productName___Entity())
    }
}
#endif
