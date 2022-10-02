// 
//  ProfileInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import Foundation
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure

final class ProfileInteractor: IOInteractor<ProfilePresenter, ProfileEntity> {
    
    // MARK: - Privates
    
    @IOInstance private var baseService: IOServiceProviderImpl<BaseService>
    @IOInstance private var service: IOServiceProviderImpl<ProfileService>
    
    // MARK: - Interactor
    
    func getMember() {
        self.showIndicator()
        
        let request = MemberGetRequestModel()
        request.userName = self.entity.userName
        
        self.service.request(.memberGet(request: request), responseType: MemberGetResponseModel.self) { [weak self] result in
            switch result {
            case .success(response: let response):
                if response.member?.profilePicturePublicId != nil {
                    self?.loadProfilePicture(member: response.member)
                } else {
                    self?.hideIndicator()
                    self?.presenter?.update(member: response.member, profilePictureData: nil)
                }
                
            case .error(message: let message, type: let type, response: let response):
                self?.hideIndicator()
                self?.handleServiceError(message, type: type, response: response, handler: nil)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func loadProfilePicture(member: MemberModel?) {
        let publicId = member!.profilePicturePublicId!
        
        do {
            let profilePictureData = try self.fileCache.getFile(fromCache: publicId)
            self.hideIndicator()
            self.presenter?.update(member: member, profilePictureData: profilePictureData)
            return
        } catch let error {
            IOLogger.debug(error.localizedDescription)
        }
        
        let request = ImageAssetRequestModel(publicId: publicId)
        
        self.baseService.request(.imageAsset(request: request), responseType: ImageAssetResponseModel.self) { [weak self] result in
            self?.hideIndicator()
            
            switch result {
            case .success(response: let response):
                self?.cacheImage(publicId: publicId, imageData: response.imageData)
                self?.presenter?.update(member: member, profilePictureData: response.imageData)
                
            case .error(message: _, type: _, response: _):
                self?.presenter?.update(member: member, profilePictureData: nil)
            }
        }
    }
    
    private func cacheImage(publicId: String, imageData: Data) {
        do {
            try self.fileCache.storeFile(toCache: publicId, fileData: imageData)
        } catch let error {
            IOLogger.debug(error.localizedDescription)
        }
    }
}
