// ___FILEHEADER___

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

struct ___VARIABLE_productName___NavigationWireframe: IONavigationLinkView {
    
    // MARK: - States
    
    @ObservedObject var navigationState: ___VARIABLE_productName___NavigationState
    
    // MARK: - Properties
    
    var body: some View {
        EmptyView()
        /*
        NavigationLink(destination: route(IORouter.sef, .sample(entity: navigationState.sampleEntity)), isActive: $navigationState.navigateToPage) {
            EmptyView()
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: ___VARIABLE_productName___NavigationState) {
        self.navigationState = navigationState
    }
}
