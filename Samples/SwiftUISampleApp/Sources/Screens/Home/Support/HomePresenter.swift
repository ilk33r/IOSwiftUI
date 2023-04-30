// 
//  HomePresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 27.08.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppPresentation

final public class HomePresenter: IOPresenterable {
    
    // MARK: - Presentable
    
    public var environment: EnvironmentObject<SampleAppEnvironment>!
    public var interactor: HomeInteractor!
    public var navigationState: StateObject<HomeNavigationState>!
    
    // MARK: - Properties
    
    @Published var actionSheetData: IOAlertData?
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Presenter
    
    func showActionSheet() {
        self.actionSheetData = IOAlertData(
            title: .cameraActionsTitle,
            message: "",
            buttons: [
                .cameraActionsTakePhoto,
                .cameraActionsChoosePhoto,
                .commonCancel
            ],
            handler: { [weak self] index in
                if index == 0 {
                    self?.navigationState.wrappedValue.navigateToCameraPage()
                } else if index == 1 {
                    self?.navigationState.wrappedValue.navigateToPhotoLibraryPage()
                }
            }
        )
    }
    
    @MainActor
    func uploadImage(image: UIImage) async {
        do {
            try await self.interactor.uploadImage(image: image)
            await self.showAlertAsync {
                IOAlertData(
                    title: nil,
                    message: .successUploadImage,
                    buttons: [.commonOk]
                )
            }
        } catch let err {
            IOLogger.error(err.localizedDescription)
        }
    }
}
