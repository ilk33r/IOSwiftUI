//
//  InboxResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class InboxResponseModel: BaseResponseModel {
    
    @IOJsonProperty(key: "inboxes")
    public var inboxes: [InboxModel]?
}
