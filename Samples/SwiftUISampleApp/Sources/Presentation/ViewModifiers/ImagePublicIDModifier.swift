//
//  ImagePublicIDModifier.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.10.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure

public extension Image {
    
    @ViewBuilder
    func from(publicId: String) -> some View {
        modifier(
            ImagePublicIDModifier(
                publicId: Binding.constant(publicId)
            )
        )
    }
    
    @ViewBuilder
    func from(publicId: Binding<String?>) -> some View {
        modifier(
            ImagePublicIDModifier(
                publicId: publicId
            )
        )
    }
}

private struct ImagePublicIDModifier: ViewModifier {
    
    // MARK: - DI
    
    @IOInject private var fileCache: IOFileCache
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private var baseService = IOServiceProviderImpl<BaseService>()
    
    @State private var image = Image()
    @State private var imageLoadCancellable: IOCancellable?
    @State private var imageLoadTask: Task<(), Never>?
    @State private var isImageLoaded = false
    
    @Binding private var publicId: String?
    
    // MARK: - Initialization Methods
    
    init(publicId: Binding<String?>) {
        self._publicId = publicId
        
        if ProcessInfo.isPreviewMode && publicId.wrappedValue?.starts(with: "pw") ?? false {
            image = Image(self.publicId ?? "", bundle: Bundle.main)
            _isImageLoaded = State(initialValue: true)
        }
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isImageLoaded {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onChange(of: publicId) { _ in
                    isImageLoaded = false
                    loadImage()
                }
        } else {
            Rectangle()
                .background(Color.colorImage)
                .shimmering(active: true)
                .onAppear {
                    loadImage()
                }
                .onDisappear {
                    cancelLoadImage()
                }
                .onChange(of: publicId) { _ in
                    isImageLoaded = false
                    loadImage()
                }
        }
    }
    
    @discardableResult
    private func loadCachedImage() -> Bool {
        if fileCache.cacheExists(name: publicId ?? "") {
            cancelLoadImage()
            
            imageLoadCancellable = thread.runOnBackgroundThread {
                loadImageFromCache()
            }
            
            return true
        }
        
        return false
    }
    
    private func loadImage() {
        if loadCachedImage() { return }
        guard let publicId else { return }
        
        imageLoadTask = Task {
            guard let imageData = await loadImageAsync(publicId: publicId) else { return }
            
            do {
                let cgImage = CGImage.create(fromJpegData: imageData)
                
                if let rawData = cgImage?.rawData() {
                    try fileCache.storeFile(toCache: publicId, fileData: rawData)
                }
                
                if let cgImage {
                    image = await Image(decorative: cgImage, scale: UIScreen.main.scale)
                }
                
                isImageLoaded = true
                cancelLoadImage()
            } catch let error {
                IOLogger.error(error.localizedDescription)
            }
        }
    }
    
    private func loadImageFromCache() {
        do {
            let cachedImage = try fileCache.getFile(fromCache: publicId ?? "")
            if let cgImage = CGImage.create(fromRawData: cachedImage) {
                imageLoadCancellable = thread.runOnMainThread {
                    image = Image(decorative: cgImage, scale: UIScreen.main.scale)
                    isImageLoaded = true
                    cancelLoadImage()
                }
            } else {
                try fileCache.removeFile(fromCache: publicId ?? "")
            }
        } catch let error {
            IOLogger.error(error.localizedDescription)
        }
    }
    
    @MainActor
    private func loadImageAsync(publicId: String) async -> Data? {
        let request = ImageAssetRequestModel(publicId: publicId)
        let result = await baseService.async(.imageAsset(request: request), responseType: ImageAssetResponseModel.self) { cancellable in
            imageLoadCancellable = cancellable
        }
        
        switch result {
        case .success(let response):
            return response.imageData
            
        case .error(let message, _, _):
            IOLogger.error(message)
        }
        
        return nil
    }
    
    private func cancelLoadImage() {
        imageLoadCancellable?.cancel()
        imageLoadTask?.cancel()
        
        imageLoadCancellable = nil
        imageLoadTask = nil
    }
}
