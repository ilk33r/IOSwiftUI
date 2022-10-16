// 
//  PhotoGalleryPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUI

final public class PhotoGalleryPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public typealias Environment = SampleAppEnvironment
    public typealias Interactor = PhotoGalleryInteractor
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: PhotoGalleryInteractor!
    
    // MARK: - Bindings
    
    @Published private(set) var imagesUIModel: [PhotoGalleryImageUIModel] = []
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func getImages() {
        self.imagesUIModel = self.interactor.entity.imagePublicIds.map { PhotoGalleryImageUIModel(imagePublicId: $0) }
    }
}
