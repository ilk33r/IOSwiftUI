// 
//  ChatInboxPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 28.08.2022.
//

import Foundation
import IOSwiftUIPresentation

final class ChatInboxPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Interactor = ChatInboxInteractor
    
    var interactor: ChatInboxInteractor!
    
    // MARK: - Initialization Methods
    
    init() {
    }
}
