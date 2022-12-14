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
import SwiftUISampleAppResources

public struct SecondaryButton: View, IOClickable {
    
    public var handler: IOClickableHandler?
    private var localizationType: IOLocalizationType
    
    public var body: some View {
        IOButton {
            ZStack {
                Color.white
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .frame(height: 52)
                Text(type: localizationType)
                    .padding([.top, .bottom], 19)
                    .padding([.leading, .trailing], 12)
                    .font(type: .black(13))
                    .foregroundColor(.black)
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
    
    public func setClick(_ handler: IOClickableHandler?) -> SecondaryButton {
        return SecondaryButton(localizationType, handler: handler)
    }
}

#if DEBUG
struct SecondaryButton_Previews: PreviewProvider {
    
    static var previews: some View {
        prepare()
        return SecondaryButton(.init(rawValue: "Secondary Button"))
    }
}
#endif
