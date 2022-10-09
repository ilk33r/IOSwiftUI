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
    
    private var imagePublicId: String
    private var type: `Type`
    private var width: CGFloat
    
    public var body: some View {
        let height: CGFloat
        if type == .normal {
            height = 310
        } else {
            height = 220
        }
        
        return Image()
            .from(publicId: imagePublicId)
            .frame(width: width, height: height, alignment: .center)
            .contentShape(RoundedRectangle(cornerRadius: 2))
            .clipped()
    }
    
    public init(
        imagePublicId: String,
        type: `Type`,
        width: CGFloat
    ) {
        self.imagePublicId = imagePublicId
        self.type = type
        self.width = width
    }
}

struct GalleryCellView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryCellView(imagePublicId: "", type: .normal, width: 90)
            .previewLayout(.sizeThatFits)
    }
}
