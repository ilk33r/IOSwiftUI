//
//  PrimaryButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI
import IOSwiftUICommon
import IOSwiftUIInfrastructure

public struct PrimaryButton: View, IOClickable {
    
    public var handler: IOClickableHandler?
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 6)
        Button(self.localizationType.localized) {
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
    
    public func setClick(_ handler: IOClickableHandler?) -> PrimaryButton {
        return PrimaryButton(self.localizationType, handler: handler)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PrimaryButton(.init(rawValue: "Primary Button"))
                .frame(width: 167, height: 52, alignment: .center)
        }
    }
}
