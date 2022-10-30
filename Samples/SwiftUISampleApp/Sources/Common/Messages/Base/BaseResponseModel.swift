//
//  BaseResponseModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUICommon

public protocol BaseResponseModel: BaseModel {
    
    // MARK: - Base Properties
    
    var _status: IOJsonProperty<ResponseStatusModel> { get set }
}

public extension BaseResponseModel {
    
    var status: ResponseStatusModel? {
        get {
            _status.wrappedValue
        }
        set {
            _status.wrappedValue = newValue
        }
    }
}
