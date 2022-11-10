// 
//  UpdateProfileEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUI

public struct UpdateProfileEntity: IOEntity {
    
    public var member: MemberModel
    
    public init(
        member: MemberModel
    ) {
        self.member = member
    }
}
