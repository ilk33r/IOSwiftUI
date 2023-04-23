//
//  ColorExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.08.2022.
//

import Foundation
import SwiftUI
import SwiftUISampleAppResources

public extension Color {
    
    static let colorBorder = Color("colorBorder", bundle: Bundle.resources)
    static let colorChatLastMessage = Color("colorChatLastMessage", bundle: Bundle.resources)
    static let colorChatSendMessage = Color("colorChatSendMessage", bundle: Bundle.resources)
    static let colorImage = Color("colorImage", bundle: Bundle.resources)
    static let colorPassthrought = Color("colorPassthrought", bundle: Bundle.resources)
    static let colorPlaceholder = Color("colorPlaceholder", bundle: Bundle.resources)
    static let colorTabEnd = Color("colorTabEnd", bundle: Bundle.resources)
    static let colorTabStart = Color("colorTabStart", bundle: Bundle.resources)
    
    func convertUI() -> UIColor {
        UIColor(self)
    }
}
