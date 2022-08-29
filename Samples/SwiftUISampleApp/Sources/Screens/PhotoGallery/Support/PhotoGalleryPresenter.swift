// 
//  PhotoGalleryPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUI

final class PhotoGalleryPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    typealias Interactor = PhotoGalleryInteractor
    
    var interactor: PhotoGalleryInteractor!
    
    // MARK: - Bindings
    
    @Published private(set) var imagesUIModel: [PhotoGalleryImageUIModel] = []
    
    // MARK: - Initialization Methods
    
    init() {
    }
    
    // MARK: - Presenter
    
    func getImages() {
        self.imagesUIModel = self.interactor.entity.images.map { PhotoGalleryImageUIModel(image: $0) }
    }
}
