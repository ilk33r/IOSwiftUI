// 
//  ChatEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 30.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUI

public struct ChatEntity: IOEntity {
    
    public let toMemberId: Int
    public let inbox: InboxModel!
    
    public init(toMemberId: Int, inbox: InboxModel!) {
        self.toMemberId = toMemberId
        self.inbox = inbox
    }
}
