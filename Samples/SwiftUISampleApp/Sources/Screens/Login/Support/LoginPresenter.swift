// 
//  LoginPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 22.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final class LoginPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Interactor = LoginInteractor
    
    var interactor: LoginInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
