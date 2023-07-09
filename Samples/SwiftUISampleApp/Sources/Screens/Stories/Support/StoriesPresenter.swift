// 
//  StoriesPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.07.2023.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class StoriesPresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: StoriesInteractor!
    public var navigationState: StateObject<StoriesNavigationState>!
    
    // MARK: - Publics
    
    // MARK: - Publishers
    
    @Published private(set) var stories: [StoriesItemUIModel]
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
        self.stories = []
    }
    
    // MARK: - Presenter
    
    func prepare() {
        self.stories = self.interactor.entity
            .allStories?
            .map {
                let images = $0.images?.map { it in
                    StoryItemUIModel(
                        relativeDate: it.createDate?.string(unitStyle: .short) ?? "",
                        userNameAndSurname: it.userNameAndSurname ?? "",
                        userProfilePicturePublicId: it.userProfilePicturePublicId,
                        publicId: it.publicId
                    )
                }
                
                return StoriesItemUIModel(images: images ?? [])
            } ?? []
    }
}

#if DEBUG
extension StoriesPresenter {
    
    func prepareForPreview() {
        
    }
}
#endif
