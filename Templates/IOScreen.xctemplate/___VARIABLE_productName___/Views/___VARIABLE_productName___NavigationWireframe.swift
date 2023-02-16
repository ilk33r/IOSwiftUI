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
        Group {
            NavigationLink(
                destination: route(IORouter.self, .sample(entity: navigationState.sampleEntity)),
                isActive: $navigationState.navigateToPage
            ) {
                EmptyView()
        }
        .fullScreenCover(isPresented: $navigationState.navigateToEditProfile) {
            if let view = navigationState.editProfileView {
                view
            } else {
                EmptyView()
            }
        }
        .sheet(isPresented: $navigationState.navigateToMap) {
            if let mapView = navigationState.mapView {
                mapView
            } else {
                EmptyView()
            }
        }
        */
    }
    
    // MARK: - Initialization Methods
    
    init(navigationState: ___VARIABLE_productName___NavigationState) {
        self.navigationState = navigationState
    }
}
