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
    
    @ViewBuilder
    func from(publicId: String) -> some View {
        modifier(ImagePublicIDModifier(publicId: publicId))
    }
}

private struct ImagePublicIDModifier: ViewModifier {
    
    @IOInject private var fileCache: IOFileCache
    
    private var baseService = IOServiceProviderImpl<BaseService>()
    
    @State private var image = Image()
    @State private var imageLoadCancellable: IOCancellable?
    @State private var isImageLoaded = false
    
    private let publicId: String
    
    init(publicId: String) {
        self.publicId = publicId
        
        if ProcessInfo.isPreviewMode && publicId.starts(with: "pw") {
            image = Image(publicId, bundle: Bundle.main)
            isImageLoaded = true
        } else {
            loadCachedImage()
        }
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isImageLoaded {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Rectangle()
                .background(Color.colorImage)
                .shimmering(active: true)
                .onAppear {
                    imageLoadCancellable = loadImage()
                }
                .onDisappear {
                    imageLoadCancellable?.cancel()
                }
        }
    }
    
    @discardableResult
    private func loadCachedImage() -> Bool {
        do {
            let cachedImage = try fileCache.getFile(fromCache: publicId)
            image = Image(fromData: cachedImage)
            isImageLoaded = true
            return true
        } catch let error {
            IOLogger.debug(error.localizedDescription)
        }
        
        return false
    }
    
    private func loadImage() -> IOCancellable? {
        if loadCachedImage() {
            return nil
        }
        
        let request = ImageAssetRequestModel(publicId: publicId)
        
        return baseService.request(.imageAsset(request: request), responseType: ImageAssetResponseModel.self) { result in
            switch result {
            case .success(response: let response):
                do {
                    try fileCache.storeFile(toCache: publicId, fileData: response.imageData)
                    image = Image(fromData: response.imageData)
                    isImageLoaded = true
                } catch let error {
                    IOLogger.debug(error.localizedDescription)
                }
                
            case .error(message: let message, type: _, response: _):
                IOLogger.error(message)
            }
        }
    }
}
