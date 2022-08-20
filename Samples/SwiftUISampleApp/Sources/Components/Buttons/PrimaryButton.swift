//
//  PrimaryButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 20.08.2022.
//

import SwiftUI
import IOSwiftUICommon

public struct PrimaryButton: View, IOClickable {
    
    public var handler: IOClickableHandler?
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 6)
        Button(.init("key")) {
            self.handler?()
        }
    }
    
    public init() {
    }
    
    private init(handler: IOClickableHandler?) {
        self.handler = handler
    }
    
    public func setClick(_ handler: IOClickableHandler?) -> PrimaryButton {
        return PrimaryButton(handler: handler)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PrimaryButton()
                .frame(width: 167, height: 52, alignment: .center)
        }
    }
}
