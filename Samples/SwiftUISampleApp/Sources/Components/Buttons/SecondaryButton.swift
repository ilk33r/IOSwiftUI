//
//  SecondaryButton.swift
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

public struct SecondaryButton: View, IOClickable {
    
    public var handler: IOClickableHandler?
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        Button(self.localizationType.localized) {
            self.handler?()
        }
        .padding([.top, .bottom], 19)
        .padding([.leading, .trailing], 12)
        .background(Color.white)
        .font(type: .black(13))
        .foregroundColor(.black)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.black, lineWidth: 2)
        )
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
    
    public func setClick(_ handler: IOClickableHandler?) -> SecondaryButton {
        return SecondaryButton(self.localizationType, handler: handler)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(.init(rawValue: "Secondary Button"))
    }
}
