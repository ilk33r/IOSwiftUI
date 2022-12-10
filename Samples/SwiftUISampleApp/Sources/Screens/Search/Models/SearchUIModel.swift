//
//  SearchUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 19.11.2022.
//

import Foundation
import SwiftUI

struct SearchUIModel: Identifiable {
    
    let imagePublicId: String
    let userName: String
    let isDummy: Bool
    let id = UUID()
    
    init(
        imagePublicId: String,
        userName: String,
        isDummy: Bool
    ) {
        self.imagePublicId = imagePublicId
        self.userName = userName
        self.isDummy = isDummy
    }
}
