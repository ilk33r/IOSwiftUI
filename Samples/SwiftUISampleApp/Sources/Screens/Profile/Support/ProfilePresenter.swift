// 
//  ProfilePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final class ProfilePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Interactor = ProfileInteractor
    
    var interactor: ProfileInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
