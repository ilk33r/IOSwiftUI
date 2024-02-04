//
//  CartUIModel.swift
//
//
//  Created by Adnan ilker Ozcan on 4.02.2024.
//

import Foundation

struct CartUIModel: Identifiable {
    
    let id = UUID()
    let picturePublicId: String
    let nameSurname: String
    let userName: String
    let price: String
    
    init(
        picturePublicId: String, 
        nameSurname: String,
        userName: String,
        price: String
    ) {
        self.picturePublicId = picturePublicId
        self.nameSurname = nameSurname
        self.userName = userName
        self.price = price
    }
}
