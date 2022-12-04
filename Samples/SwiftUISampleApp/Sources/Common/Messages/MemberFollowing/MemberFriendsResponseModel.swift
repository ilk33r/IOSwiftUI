//
//  MemberFriendsResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 4.12.2022.
//

import Foundation
import IOSwiftUICommon

public struct MemberFriendsResponseModel: BaseResponseModel {
    
    public var _status: IOJsonProperty<ResponseStatusModel>
    
    @IOJsonProperty(key: "followers")
    public var followers: [MemberFriendModel]?
    
    @IOJsonProperty(key: "followings")
    public var followings: [MemberFriendModel]?
    
    public init() {
        _status = IOJsonProperty(key: "status")
    }
}
