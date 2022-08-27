// 
//  HomePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final public class HomePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public typealias Interactor = HomeInteractor
    
    public var interactor: HomeInteractor!
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}
