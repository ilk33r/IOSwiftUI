//
//  IOSwiftUIPresentation_Previews.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import SwiftUI

struct IOSwiftUIPresentation_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return Group {
            IOButton(.init(rawValue: "Primary Button"))
        }
    }
}
