//
//  UserLocationMapPin.swift
//  
//
//  Created by Adnan ilker Ozcan on 8.11.2022.
//

import CoreLocation
import Foundation

struct UserLocationMapPin: Identifiable {
    
    var id = UUID()
    
    let coordinate: CLLocationCoordinate2D
}
