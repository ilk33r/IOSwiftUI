// 
//  IOImageCropView.swift
//  
//
//  Created by Adnan ilker Ozcan on 5.02.2023.
//

import Foundation
import SwiftUI
import IOSwiftUIInfrastructure

public struct IOImageCropView: View {
    
    // MARK: - Defs
    
    private final class ViewData {
        
        weak var imageCropView: IOImageCropUIScrollView?
    }
    
    // MARK: - Privates
    
    private let image: UIImage
    private let size: CGSize
    private let viewData: ViewData

    @State private var lastScaleValue: CGFloat = 1
    @State private var scale: CGFloat = 1
    
    @Environment(\.displayScale) var displayScale
    
    // MARK: - Body

    public var body: some View {
        GeometryReader { proxy in
            IOImageCropUIView { view in
                viewData.imageCropView = view
                view.image = image
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(
        image: UIImage
    ) {
        self.image = image
        self.size = image.size
        self.viewData = ViewData()
    }
    
    // MARK: - Render Methods
    
    public func getImage() -> UIImage? {
        return viewData.imageCropView?.cropImage()
    }
}

#if DEBUG
struct IOImageCropView_Previews: PreviewProvider {
    
    struct IOImageCropViewDemo: View {
        
        var body: some View {
            IOImageCropView(image: .init())
        }
    }
    
    static var previews: some View {
        prepare()
        return IOImageCropViewDemo()
    }
}
#endif
