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
import SwiftUISampleAppResources

public struct PrimaryButton: View, IOClickable {
    
    public var handler: IOClickableHandler?
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        IOButton {
            ZStack {
                Color.black
                    .cornerRadius(6)
                Text(type: localizationType)
                    .padding([.top, .bottom], 19)
                    .padding([.leading, .trailing], 12)
                    .font(type: .black(13))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
        }
        .setClick(handler)
        .frame(height: 52)
    }
    
    public init(_ l: IOLocalizationType) {
        self.localizationType = l
    }
    
    private init(_ l: IOLocalizationType, handler: IOClickableHandler?) {
        self.localizationType = l
        self.handler = handler
    }
    
    public func setClick(_ handler: IOClickableHandler?) -> PrimaryButton {
        return PrimaryButton(localizationType, handler: handler)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return Group {
            PrimaryButton(.init(rawValue: "Primary Button"))
            PrimaryButton(.init(rawValue: "Primary Button"))
        }
    }
}
