// 
//  ChatPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final class ChatPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Interactor = ChatInteractor
    
    var interactor: ChatInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
