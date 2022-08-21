//
//  IOButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import SwiftUI
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation

public struct IOButton: View, IOClickable {
    
    public var handler: IOClickableHandler?
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        Button(localizationType.localized) {
            self.handler?()
        }
    }
    
    public init(_ l: IOLocalizationType) {
        self.localizationType = l
    }
    
    private init(_ l: IOLocalizationType, handler: IOClickableHandler?) {
        self.localizationType = l
        self.handler = handler
    }
    
    public func setClick(_ handler: IOClickableHandler?) -> IOButton {
        return IOButton(localizationType, handler: handler)
    }
}

struct IOButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IOButton(.init(rawValue: "Button"))
        }
    }
}
