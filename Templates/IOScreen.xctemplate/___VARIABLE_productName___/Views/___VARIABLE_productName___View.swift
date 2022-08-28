// ___FILEHEADER___

import IOSwiftUIPresentation
import SwiftUI

struct ___VARIABLE_productName___View: IOController {
    
    // MARK: - Generics
    
    typealias Presenter = ___VARIABLE_productName___Presenter
    
    // MARK: - Properties
    
    @ObservedObject public var presenter: ___VARIABLE_productName___Presenter
    @StateObject public var navigationState = ___VARIABLE_productName___NavigationState()
    
    var body: some View {
        Text("___VARIABLE_productName___")
            .controller {
                ___VARIABLE_productName___NavigationWireframe(navigationState: navigationState)
            }
    }
    
    // MARK: - Initialization Methods
    
    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View(entity: ___VARIABLE_productName___Entity())
    }
}
