//
//  IOBottomSheetContentView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import SwiftUI

public class IOBottomSheetContentViewData {
    
    weak var presenter: IOBottomSheetPresenter?
}

public protocol IOBottomSheetContentView: View {

    var animationDuration: Double { get }
    var data: IOBottomSheetContentViewData! { get set }
}
