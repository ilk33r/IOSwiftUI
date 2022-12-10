//
//  SearchCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 26.11.2022.
//

import SwiftUI
import IOSwiftUICommon

struct SearchCellView: View {
    
    // MARK: - Defs
    
    typealias ClickHandler = (_ userName: String) -> Void
    
    // MARK: - Privates
    
    private let clickHandler: ClickHandler?
    private let imageWidth: CGFloat
    private let uiModel: SearchUIModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image()
                .from(publicId: uiModel.imagePublicId)
                .frame(width: imageWidth, height: imageWidth)
                .clipped()
                .allowsHitTesting(false)
            
            Text(uiModel.userName)
                .font(type: .regular(11))
                .foregroundColor(.black.opacity(0.8))
        }
        .padding(.bottom, 8)
        .setClick {
            clickHandler?(uiModel.userName)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        imageWidth: CGFloat,
        uiModel: SearchUIModel,
        handler: ClickHandler?
    ) {
        self.imageWidth = imageWidth
        self.uiModel = uiModel
        self.clickHandler = handler
    }
}

#if DEBUG
struct SearchCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return SearchCellView(
            imageWidth: 180,
            uiModel: SearchUIModel(
                imagePublicId: "pwGallery4",
                userName: "ilker"
            ),
            handler: { _ in
                
            }
        )
    }
}
#endif
