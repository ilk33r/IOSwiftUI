//
//  IOToastPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.01.2023.
//

import Foundation

public protocol IOToastPresenter {
    
    func show(handler: @escaping IOToastData.DataHandler)
    func dismiss()
}
