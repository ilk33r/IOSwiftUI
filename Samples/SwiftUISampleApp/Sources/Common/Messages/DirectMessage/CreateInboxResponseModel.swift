//
//  CreateInboxResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 15.10.2022.
//

import Foundation
import IOSwiftUICommon

final public class CreateInboxResponseModel: BaseResponseModel {
    
    @IOJsonProperty(key: "inbox")
    public var inbox: InboxModel?
}
