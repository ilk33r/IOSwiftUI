//
//  GetMessagesRequestModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class GetMessagesRequestModel: BaseRequestModel {
    
    @IOJsonProperty(key: "toMemberID")
    public var toMemberID: Int?
}
