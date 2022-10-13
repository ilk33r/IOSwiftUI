//
//  DiscoverCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 3.09.2022.
//

import SwiftUI
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

struct DiscoverCellView: View {

    typealias ClickHandler = (_ userName: String?) -> Void
    
    private var handler: ClickHandler?
    private var uiModel: DiscoverUIModel
    private var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Image()
                .from(publicId: uiModel.imagePublicId)
                .frame(width: (width > 32) ? width - 32 : width, height: width)
                .clipped()
                .allowsHitTesting(false)
            
            HStack(alignment: .top) {
                
                Image()
                    .from(publicId: uiModel.userAvatarPublicId)
                    .frame(width: 28, height: 28)
                    .contentShape(Rectangle())
                    .clipShape(Circle())
                    .setClick {
                        handler?(uiModel.userName)
                    }
                
                VStack(alignment: .leading) {
                    Text(uiModel.userNameAndSurname)
                        .font(type: .bold(13))
                        .foregroundColor(.black)
                    Text(uiModel.userName)
                        .font(type: .regular(11))
                        .foregroundColor(.black.opacity(0.8))
                }
                .setClick {
                    handler?(uiModel.userName)
                }
                
                Spacer()
                
                Text(uiModel.messageTime)
                    .font(type: .thin(12))
                    .foregroundColor(.colorPlaceholder)
            }
            .padding(.top, 16)
        }
        .padding([.trailing, .leading], 16)
        .padding(.bottom, 24)
    }
    
    init(
        uiModel: DiscoverUIModel,
        width: CGFloat,
        handler: ClickHandler?
    ) {
        self.handler = handler
        self.uiModel = uiModel
        self.width = width
    }
}

struct DiscoverCellView_Previews: PreviewProvider {
    
    struct DiscoverCellViewDemo: View {
        
        var body: some View {
            DiscoverCellView(
                uiModel: DiscoverUIModel(
                    imagePublicId: "pwGallery3",
                    userName: "@ridzjcob!",
                    userNameAndSurname: "Ridhwan Nordin",
                    userAvatarPublicId: "pwChatAvatar",
                    messageTime: "16 min ago"
                ),
                width: 375
            ) { _ in
                
            }
        }
    }
    
    static var previews: some View {
        DiscoverCellViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
