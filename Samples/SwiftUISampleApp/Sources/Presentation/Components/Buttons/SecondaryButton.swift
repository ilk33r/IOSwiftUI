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
    
    private let title: String
    
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
                
                Text(title)
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
        self.init(l.localized)
    }
    
    public init(_ title: String) {
        self.title = title
    }
    
    private init(_ title: String, handler: IOClickableHandler?) {
        self.title = title
        self.handler = handler
    }
    
    // MARK: - Clickable
    
    public func setClick(_ handler: IOClickableHandler?) -> SecondaryButton {
        Self(title, handler: handler)
    }
}

#if DEBUG
struct SecondaryButton_Previews: PreviewProvider {
    
    struct SecondaryButtonDemo: View {
        
        var body: some View {
            SecondaryButton("Secondary Button")
        }
    }
    
    static var previews: some View {
        prepare()
        return SecondaryButtonDemo()
    }
}
#endif
