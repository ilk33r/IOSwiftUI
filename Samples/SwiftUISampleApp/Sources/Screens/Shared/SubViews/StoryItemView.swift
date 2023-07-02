//
//  StoryItemView.swift
//
//
//  Created by Adnan ilker Ozcan on 1.07.2023.
//

import Foundation
import SwiftUI
import SwiftUISampleAppPresentation

struct StoryItemView: View {
    
    // MARK: - Privates
    
    private var uiModel: StoryItemUIModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if let userName = uiModel.userName {
                ProfilePictureImageView(
                    imagePublicID: Binding.constant(uiModel.userProfilePicturePublicId)
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [.colorTabStart, .colorTabEnd]),
                                startPoint: .topLeading,
                                endPoint: .bottomLeading
                            ),
                            lineWidth: 2
                        )
                )
                .padding(.top, 2)
                .frame(width: 62, height: 62)
                
                Text(userName)
                    .font(type: .systemRegular(12))
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .padding(.top, 4)
            } else {
                Circle()
                    .shimmering(active: true)
                    .padding(.top, 2)
                    .frame(width: 62, height: 62)
                
                Rectangle()
                    .shimmering(active: true)
                    .padding(.top, 4)
            }
        }
        .frame(width: 64, height: 88)
    }
    
    // MARK: - Initialization Methods
    
    init(uiModel: StoryItemUIModel) {
        self.uiModel = uiModel
    }
}

#if DEBUG
struct StoryItemView_Previews: PreviewProvider {
    
    struct StoryItemViewDemo: View {
        
        var body: some View {
            StoryItemView(
                uiModel: StoryPreviewData.previewDataCell
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return StoryItemViewDemo()
    }
}
#endif
