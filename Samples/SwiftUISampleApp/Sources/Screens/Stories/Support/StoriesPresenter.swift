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
    
    // MARK: - Privates
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
}

#if DEBUG
extension StoriesPresenter {
    
    func prepareForPreview() {
        
    }
}
#endif
