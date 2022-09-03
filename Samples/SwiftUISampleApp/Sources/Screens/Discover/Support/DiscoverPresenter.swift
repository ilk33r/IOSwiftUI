// 
//  DiscoverPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.09.2022.
//

import Foundation
import IOSwiftUIPresentation

final class DiscoverPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Interactor = DiscoverInteractor
    
    var interactor: DiscoverInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
