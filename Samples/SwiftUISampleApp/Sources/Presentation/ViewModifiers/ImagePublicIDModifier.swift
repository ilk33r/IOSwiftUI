//
//  ImagePublicIDModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import SwiftUI
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure

public extension Image {
    
    func from(publicId: String) -> some View {
        modifier(ImagePublicIDModifier(publicId: publicId))
    }
}

struct ImagePublicIDModifier: ViewModifier {
    
    @IOInject private var fileCache: IOFileCache
    
    private var baseService = IOServiceProviderImpl<BaseService>()
    
    @State private var imageData: Data?
    @State private var imageLoadCancellable: IOCancellable?
    
    private let publicId: String
    
    init(publicId: String) {
        self.publicId = publicId
    }
    
    func body(content: Content) -> some View {
        if
            ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" &&
                publicId.starts(with: "pw")
        {
            return AnyView(
                Image(publicId)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
        }
        
        if let imageData {
            return AnyView(
                Image(fromData: imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
        }
        
        return AnyView(
            Image(systemName: "scribble")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    imageLoadCancellable = loadImage()
                }
                .onDisappear {
                    imageLoadCancellable?.cancel()
                }
        )
    }
    
    private func loadImage() -> IOCancellable? {
        do {
            let cachedImage = try fileCache.getFile(fromCache: publicId)
            imageData = cachedImage
            return nil
        } catch let error {
            IOLogger.debug(error.localizedDescription)
        }
        
        let request = ImageAssetRequestModel(publicId: publicId)
        
        return baseService.request(.imageAsset(request: request), responseType: ImageAssetResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                do {
                    try fileCache.storeFile(toCache: publicId, fileData: response.imageData)
                    imageData = response.imageData
                } catch let error {
                    IOLogger.debug(error.localizedDescription)
                }
                
            case .error(message: let message, type: _, response: _):
                IOLogger.error(message)
            }
        }
    }
}
