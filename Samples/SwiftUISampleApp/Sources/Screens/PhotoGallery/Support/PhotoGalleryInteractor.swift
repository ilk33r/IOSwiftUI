// 
//  PhotoGalleryInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared

public struct PhotoGalleryInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: PhotoGalleryEntity!
    public weak var presenter: PhotoGalleryPresenter?
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}
