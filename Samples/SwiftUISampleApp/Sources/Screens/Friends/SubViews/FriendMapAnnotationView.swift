// 
//  FriendMapAnnotationView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.06.2023.
//

import CoreLocation
import Foundation
import SwiftUI
import SwiftUISampleAppPresentation

struct FriendMapAnnotationView: View {
    
    // MARK: - Privates
    
    let uiModel: FriendMapPinUIModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ProfilePictureImageView(
                imagePublicID: Binding.constant(uiModel.profilePicturePublicId)
            )
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            Text(uiModel.nameSurname)
                .foregroundColor(.black)
                .font(type: .medium(10))
                .padding(.top, 4)
        }
    }
    
    // MARK: - Initialization Methods
    
    init(
        uiModel: FriendMapPinUIModel
    ) {
        self.uiModel = uiModel
    }
}

#if DEBUG
struct FriendMapAnnotationView_Previews: PreviewProvider {
    
    struct FriendMapAnnotationViewDemo: View {
        
        var body: some View {
            FriendMapAnnotationView(
                uiModel: FriendMapPinUIModel(
                    coordinate: CLLocationCoordinate2D(
                        latitude: 41.06611,
                        longitude: 28.71631
                    ),
                    nameSurname: "Ilker",
                    profilePicturePublicId: nil
                )
            )
        }
    }
    
    static var previews: some View {
        prepare()
        return FriendMapAnnotationViewDemo()
    }
}
#endif
