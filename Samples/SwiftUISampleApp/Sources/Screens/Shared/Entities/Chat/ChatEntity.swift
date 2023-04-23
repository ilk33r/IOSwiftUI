// 
//  ChatEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppCommon

public struct ChatEntity: IOEntity {
    
    public let toMemberId: Int?
    public let inbox: InboxModel!
    public let messages: [MessageModel]
    public let pagination: PaginationModel
    
    public init(toMemberId: Int?, inbox: InboxModel!, messages: [MessageModel], pagination: PaginationModel) {
        self.toMemberId = toMemberId
        self.inbox = inbox
        self.messages = messages
        self.pagination = pagination
    }
}
