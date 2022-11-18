//
//  SwiftUISampleAppPresentation.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import Foundation
import SwiftUI

struct SwiftUISampleAppPresentation_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return Group {
            PrimaryButton(.init(rawValue: "Primary Button"))
            SecondaryButton(.init(rawValue: "Primary Button"))
        }
    }
}
