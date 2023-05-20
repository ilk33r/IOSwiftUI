// ___FILEHEADER___

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI

final public class ___VARIABLE_productName___Presenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<TAppEnvironment>!
    public var interactor: ___VARIABLE_productName___Interactor!
    public var navigationState: StateObject<___VARIABLE_productName___NavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
}

#if DEBUG
extension ___VARIABLE_productName___Presenter {
    
    func prepareForPreview() {
        
    }
}
#endif
