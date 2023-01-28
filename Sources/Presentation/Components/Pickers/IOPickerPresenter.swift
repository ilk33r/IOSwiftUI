//
//  IOPickerPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.01.2023.
//

import Foundation

public protocol IOPickerPresenter {
    
    func show(handler: @escaping IOPickerData.DataHandler)
    func show(handler: @escaping IODatePickerData.DataHandler)
    
    func dismiss()
}
