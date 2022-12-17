//
//  IOBottomSheetPresenter.swift
//  
//
//  Created by Adnan ilker Ozcan on 11.12.2022.
//

import Foundation
import SwiftUI

public protocol IOBottomSheetPresenter: AnyObject {
    
    typealias Handler<Content: IOBottomSheetContentView> = () -> Content
    
    func show<Content: IOBottomSheetContentView>(_ handler: Handler<Content>)
    func dismiss()
}
