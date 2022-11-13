// 
//  WebEntity.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

public struct WebEntity: IOEntity {
    
    public let pageName: String
    public let pageTitle: IOLocalizationType
    public let titleIcon: String
    
    public init(
        pageName: String,
        pageTitle: IOLocalizationType,
        titleIcon: String
    ) {
        self.pageName = pageName
        self.pageTitle = pageTitle
        self.titleIcon = titleIcon
    }
}
