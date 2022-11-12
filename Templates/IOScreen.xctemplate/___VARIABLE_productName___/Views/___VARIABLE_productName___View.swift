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
    
    @EnvironmentObject private var appEnvironment: IOAppEnvironmentObject
    
    // MARK: - Body
    
    public var body: some View {
        Text("___VARIABLE_productName___")
//            .navigationWireframe {
//                ___VARIABLE_productName___NavigationWireframe(navigationState: navigationState)
//            }
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

struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View(entity: ___VARIABLE_productName___Entity())
    }
}
