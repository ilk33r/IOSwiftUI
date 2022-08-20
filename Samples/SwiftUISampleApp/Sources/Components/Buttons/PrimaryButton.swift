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
        ZStack {
            RoundedRectangle(cornerRadius: 6)
            Button(self.localizationType.localized) {
                self.handler?()
            }
            .font(type: .black(13))
            .foregroundColor(.white)
        }
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
        PrimaryButton(.init(rawValue: "Primary Button"))
            .frame(width: 167, height: 52, alignment: .center)
    }
}
