//
//  FriendMapPinUIModel.swift
//  
//
//  Created by Adnan ilker Ozcan on 10.06.2023.
//

import CoreLocation
import Foundation

struct FriendMapPinUIModel: Identifiable {
    
    var id = UUID()
    
    let coordinate: CLLocationCoordinate2D
}
