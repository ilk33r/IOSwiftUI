// 
//  StoryListView.swift
//  
//
//  Created by Adnan ilker Ozcan on 1.07.2023.
//

import Foundation
import SwiftUI

public struct StoryListView: View {
    
    // MARK: - Defs
    
    public typealias ClickHandler = (_ id: UUID) -> Void
    
    // MARK: - Privates
    
    private var clickHandler: ClickHandler?
    
    @Binding private var uiModels: [StoryItemUIModel]?
    
    private var emptyData: [StoryItemUIModel] {
        .init(
            repeating: StoryItemUIModel(
                userProfilePicturePublicId: nil,
                userName: nil
            ),
            count: 6
        )
    }
    
    // MARK: - Body
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                if let uiModels {
                    ForEach(uiModels) { it in
                        StoryItemView(uiModel: it)
                            .frame(width: 64, height: 88)
                            .setClick {
                                clickHandler?(it.id)
                            }
                    }
                } else {
                    ForEach(emptyData) { it in
                        StoryItemView(uiModel: it)
                            .frame(width: 64, height: 88)
                    }
                }
            }
            .frame(height: 88)
        }
        .frame(height: 88)
    }
    
    // MARK: - Initialization Methods
    
    public init(
        uiModels: Binding<[StoryItemUIModel]?>,
        handler: ClickHandler?
    ) {
        self.clickHandler = handler
        self._uiModels = uiModels
    }
}

#if DEBUG
struct StoryListView_Previews: PreviewProvider {
    
    struct StoryListViewDemo: View {
        
        var body: some View {
            StoryListView(
                uiModels: Binding.constant(StoryPreviewData.previewData), 
                handler: nil
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return StoryListViewDemo()
    }
}
#endif
