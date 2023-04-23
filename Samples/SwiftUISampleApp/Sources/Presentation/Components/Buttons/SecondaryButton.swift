//
//  SecondaryButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUI
import SwiftUISampleAppResources

public struct SecondaryButton: View, IOClickable {
    
    // MARK: - Publics
    
    public var handler: IOClickableHandler?
    
    // MARK: - Privates
    
    private var localizationType: IOLocalizationType
    
    // MARK: - Body
    
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
    
    // MARK: - Initialization Methods
    
    public init(_ l: IOLocalizationType) {
        self.localizationType = l
    }
    
    private init(_ l: IOLocalizationType, handler: IOClickableHandler?) {
        self.localizationType = l
        self.handler = handler
    }
    
    // MARK: - Clickable
    
    public func setClick(_ handler: IOClickableHandler?) -> SecondaryButton {
        Self(localizationType, handler: handler)
    }
}

#if DEBUG
struct SecondaryButton_Previews: PreviewProvider {
    
    struct SecondaryButtonDemo: View {
        
        var body: some View {
            SecondaryButton(.init(rawValue: "Primary Button"))
        }
    }
    
    static var previews: some View {
        prepare()
        return SecondaryButtonDemo()
    }
}
#endif
