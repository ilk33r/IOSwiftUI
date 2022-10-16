//
//  GalleryRouters.swift
//  
//
//  Created by Adnan ilker Ozcan on 16.10.2022.
//

import Foundation
import IOSwiftUIPresentation
import IOSwiftUIScreensShared

public enum GalleryRouters: IORouterDefinition {

    case gallery(entity: PhotoGalleryEntity?)
    
    public var entity: IOEntity? {
        switch self {
        case .gallery(entity: let entity):
            return entity
        }
    }
    
    public var viewName: String {
        switch self {
        case .gallery:
            return "PhotoGalleryView"
        }
    }
}
