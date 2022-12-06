// 
//  FriendsInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppScreensShared

public struct FriendsInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: FriendsEntity!
    public weak var presenter: FriendsPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<FriendsService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func getFriends() {
        presenter?.update(friendsResponse: entity.friends)
    }
}
