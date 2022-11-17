// ___FILEHEADER___

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

public struct ___VARIABLE_productName___Interactor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: ___VARIABLE_productName___Entity!
    public weak var presenter: ___VARIABLE_productName___Presenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<___VARIABLE_productName___Service>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
}
