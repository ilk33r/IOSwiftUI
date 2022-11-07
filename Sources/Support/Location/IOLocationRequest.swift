//
//  IOLocationRequest.swift
//  
//
//  Created by Adnan ilker Ozcan on 6.11.2022.
//

import CoreLocation
import Foundation

public struct IOLocationRequest {
    
    public typealias Handler = (_ status: Bool, _ currentLocation: CLLocation?) -> Void
    public typealias ID = Int
    
    public let isSignificant: Bool
    public let isSingleRequest: Bool
    public let handler: Handler?
    public let requestId: ID

    public init(isSignificant: Bool, isSingleRequest: Bool, handler: Handler?, requestId: ID) {
        self.isSignificant = isSignificant
        self.isSingleRequest = isSingleRequest
        self.handler = handler
        self.requestId = requestId
    }
}
