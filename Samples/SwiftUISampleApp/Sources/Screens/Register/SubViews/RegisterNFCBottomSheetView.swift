// 
//  RegisterNFCBottomSheetView.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import SwiftUI
import SwiftUISampleAppCommon
import SwiftUISampleAppInfrastructure
import SwiftUISampleAppPresentation

struct RegisterNFCBottomSheetView: View {
    
    // MARK: - Privates
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Image(systemName: "lanyardcard")
                .resizable()
                .frame(width: 36, height: 50)
            Text(type: .registerNfcInfo0)
                .font(type: .regular(14))
                .lineLimit(0)
                .padding(.top, 8)
            Text(type: .registerNfcInfo1)
                .font(type: .regular(14))
                .lineLimit(0)
                .padding(.top, 8)
            PrimaryButton(.commonNextUppercased)
                .padding(16)
        }
    }
    
    // MARK: - Initialization Methods
    
    init() {
    }
}

#if DEBUG
struct RegisterNFCBottomSheetView_Previews: PreviewProvider {
    
    struct RegisterNFCBottomSheetViewDemo: View {
        
        var body: some View {
            RegisterNFCBottomSheetView()
        }
    }
    
    static var previews: some View {
        prepare()
        return RegisterNFCBottomSheetViewDemo()
    }
}
#endif
