//
//  DiscoverCellView.swift
//  
//
//  Created by Adnan ilker Ozcan on 3.09.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppInfrastructure
import SwiftUISampleAppPresentation

struct DiscoverCellView: View {

    // MARK: - Defs
    
    typealias ClickHandler = (_ userName: String?) -> Void
    
    // MARK: - Privates
    
    private var cartHandler: CartHandler?
    private var handler: ClickHandler?
    private var uiModel: DiscoverUIModel
    private var width: CGFloat
    
    @State private var userAvatarPublicId: String?
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            Image()
                .from(publicId: uiModel.imagePublicId)
                .frame(width: (width > 32) ? width - 32 : width, height: width)
                .clipped()
                .allowsHitTesting(false)
            
            HStack(alignment: .top) {
                
                ProfilePictureImageView(
                    imagePublicID: $userAvatarPublicId
                )
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
            
            ZStack {
                CartButton()
                    .setClick {
                        cartHandler?(uiModel.imagePublicId)
                    }
            }
            .padding(.top, 0)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Divider()
        }
        .padding([.trailing, .leading], 16)
        .padding(.bottom, 24)
    }
    
    // MARK: - Initialization Methods
    
    init(
        uiModel: DiscoverUIModel,
        width: CGFloat,
        handler: ClickHandler?,
        cartHandler: CartHandler?
    ) {
        self.cartHandler = cartHandler
        self.handler = handler
        self.uiModel = uiModel
        self.width = width
        self._userAvatarPublicId = State(initialValue: uiModel.userAvatarPublicId)
    }
}

#if DEBUG
struct DiscoverCellView_Previews: PreviewProvider {
    
    struct DiscoverCellViewDemo: View {
        
        var body: some View {
            DiscoverCellView(
                uiModel: DiscoverPreviewData.previewDataCell,
                width: 375
            ) { _ in
                
            } cartHandler: { _ in
                
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return DiscoverCellViewDemo()
            .previewLayout(.sizeThatFits)
    }
}
#endif
