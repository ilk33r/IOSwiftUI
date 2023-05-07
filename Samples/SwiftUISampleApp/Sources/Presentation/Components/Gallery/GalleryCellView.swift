//
//  GalleryCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI

public struct GalleryCellView: View, Identifiable {
 
    // MARK: - Defs
    
    public enum `Type` {
        case small
        case normal
    }
    
    // MARK: - Identifiable
    
    public var id: String
    
    // MARK: - Privates
    
    private var imagePublicId: String
    private var type: `Type`
    private var width: CGFloat
    
    // MARK: - Body
    
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
    
    // MARK: - Initialization Methods
    
    public init(
        imagePublicId: String,
        type: `Type`,
        width: CGFloat
    ) {
        self.imagePublicId = imagePublicId
        self.type = type
        self.width = width
        self.id = imagePublicId
    }
}

#if DEBUG
struct GalleryCellView_Previews: PreviewProvider {
    
    struct GalleryCellViewDemo: View {
        
        var body: some View {
            GalleryCellView(imagePublicId: "", type: .normal, width: 90)
        }
    }
    
    static var previews: some View {
        prepare()
        return GalleryCellViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
#endif
