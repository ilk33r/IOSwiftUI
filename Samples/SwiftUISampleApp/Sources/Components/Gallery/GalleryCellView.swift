//
//  GalleryCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI

public struct GalleryCellView: View {
    
    public enum `Type` {
        case small
        case normal
    }
    
    private var image: Image
    private var type: `Type`
    private var width: CGFloat
    
    public var body: some View {
        let height: CGFloat
        if type == .normal {
            height = 310
        } else {
            height = 220
        }
        
        return image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height, alignment: .center)
            .contentShape(RoundedRectangle(cornerRadius: 2))
            .clipped()
    }
    
    public init(
        image: Image,
        type: `Type`,
        width: CGFloat
    ) {
        self.image = image
        self.type = type
        self.width = width
    }
}

struct GalleryCellView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryCellView(image: Image("pwGallery1"), type: .normal, width: 90)
            .previewLayout(.sizeThatFits)
    }
}
