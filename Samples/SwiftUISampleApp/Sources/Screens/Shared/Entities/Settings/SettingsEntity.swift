// 
//  SettingsEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.11.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppCommon

public struct SettingsEntity: IOEntity {
    
    public var member: MemberModel
    
    public init(member: MemberModel) {
        self.member = member
    }
}
