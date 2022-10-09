//
//  PositionIndicator.swift
//  
//
//  Created by Adnan ilker Ozcan on 9.10.2022.
//

import Foundation
import SwiftUI

public struct PositionPreferenceKey: PreferenceKey {

    public typealias Value = [PositionIndicator.Position]

    public static var defaultValue = [PositionIndicator.Position]()

    public static func reduce(value: inout [PositionIndicator.Position], nextValue: () -> [PositionIndicator.Position]) {
        value.append(contentsOf: nextValue())
    }
}

public struct PositionIndicator: View {
    
    // MARK: - Defs
    
    public enum PositionType {
        case fixed
        case moving
    }
    
    public struct Position: Equatable {
        let type: PositionType
        let y: CGFloat
    }
    
    // MARK: - Publics
    
    let type: PositionType

    // MARK: - Body
    
    public var body: some View {
        GeometryReader { proxy in
            // the View itself is an invisible Shape that fills as much as possible
            Color.clear
                .preference(key: PositionPreferenceKey.self, value: [Position(type: type, y: proxy.frame(in: .global).minY)])
        }
    }
    
    // MARK: - Initialization Methods
    
    public init(type: PositionType) {
        self.type = type
    }
}
