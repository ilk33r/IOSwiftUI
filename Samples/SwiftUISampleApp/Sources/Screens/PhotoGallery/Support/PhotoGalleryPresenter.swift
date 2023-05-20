// 
//  PhotoGalleryPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class PhotoGalleryPresenter: IOPresenterable {
    
    // MARK: - Presentable

    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: PhotoGalleryInteractor!
    public var navigationState: StateObject<PhotoGalleryNavigationState>!
    
    // MARK: - Bindings
    
    @Published private(set) var imagesUIModel: [PhotoGalleryImageUIModel]
    
    // MARK: - Initialization Methods
    
    public init() {
        self.imagesUIModel = []
    }
    
    // MARK: - Presenter
    
    func prepare() {
        self.imagesUIModel = self.interactor.entity.imagePublicIds.map { PhotoGalleryImageUIModel(imagePublicId: $0) }
    }
}
