// ___FILEHEADER___

import Foundation
import IOSwiftUIPresentation
import SwiftUI

struct ___VARIABLE_productName___NavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ___VARIABLE_productName___NavigationState
    
    // MARK: - Properties
    
    var linkBody: some View {
        EmptyView()
        /*
        NavigationLink(destination: PageView(), isActive: $navigationState.navigateToPage) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: LoginNavigationState) {
        self.navigationState = navigationState
    }
}
