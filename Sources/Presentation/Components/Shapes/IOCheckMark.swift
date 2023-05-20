//
//  IOCheckMark.swift
//  
//
//  Created by Adnan ilker Ozcan on 2.02.2023.
//

import Foundation
import SwiftUI

public struct IOCheckMark: Shape {
    
    // MARK: - Initialization Methods
    
    public init() {
        
    }
    
    // MARK: - Drawing
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
                
        let width = rect.size.width
        let height = rect.size.height
        
        // Create check mark lines
        path.move(to: CGPoint(x: width / 3.1578, y: height / 2))
        path.addLine(to: CGPoint(x: width / 2.0618, y: height / 1.57894))
        path.addLine(to: CGPoint(x: width / 1.3953, y: height / 2.7272))
        
        return path
    }
}

#if DEBUG
struct IOCheckMark_Previews: PreviewProvider {
    
    struct IOCheckMarkDemo: View {
        
        var body: some View {
            ZStack {
                IOCheckMark()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 90, height: 90)
            }
        }
    }
    
    static var previews: some View {
        prepare()
        return IOCheckMarkDemo()
    }
}
#endif
