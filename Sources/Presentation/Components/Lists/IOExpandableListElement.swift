//
//  IOExpandableListElement.swift
//  
//
//  Created by Adnan ilker Ozcan on 3.02.2023.
//

import Foundation

public protocol IOExpandableListElement: Identifiable<Int> {
    
    var isSection: Bool { get set }
}
