//
//  PrimaryButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppPresentation
import SwiftUISampleAppResources

public struct PrimaryButton: View, IOClickable {
    
    public var handler: IOClickableHandler?
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        Button(self.localizationType.localized) {
            self.handler?()
        }
        .padding([.top, .bottom], 19)
        .padding([.leading, .trailing], 12)
        .background(Color.black)
        .cornerRadius(6)
        .font(type: .black(13))
        .foregroundColor(.white)
    }
    
    public init(_ l: IOLocalizationType) {
        self.localizationType = l
        IOFontTypes.registerFontsIfNecessary(Bundle.resources)
    }
    
    private init(_ l: IOLocalizationType, handler: IOClickableHandler?) {
        self.localizationType = l
        self.handler = handler
        IOFontTypes.registerFontsIfNecessary(Bundle.resources)
    }
    
    public func setClick(_ handler: IOClickableHandler?) -> PrimaryButton {
        return PrimaryButton(self.localizationType, handler: handler)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrimaryButton(.init(rawValue: "Primary Button"))
            PrimaryButton(.init(rawValue: "Primary Button"))
        }
    }
}
