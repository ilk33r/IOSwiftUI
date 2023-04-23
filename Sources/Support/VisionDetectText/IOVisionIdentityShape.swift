// 
//  IOVisionIdentityShape.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import SwiftUI

public struct IOVisionIdentityShape: Shape {
    
    // MARK: - Privates
    
    // MARK: - Drawing
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.size.width
        let height = rect.size.height
        
        // Border
        path.move(to: CGPoint(x: 10, y: 0))
        path.addLine(to: CGPoint(x: width - 10, y: 0))
        path.addArc(
            center: CGPoint(x: width - 10, y: 10),
            radius: 10,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: width, y: height - 10))
        path.addArc(
            center: CGPoint(x: width - 10, y: height - 10),
            radius: 10,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 90),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: 10, y: height))
        path.addArc(
            center: CGPoint(x: 10, y: height - 10),
            radius: 10,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 180),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: 0, y: 10))
        path.addArc(
            center: CGPoint(x: 10, y: 10),
            radius: 10,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        path.closeSubpath()
        
        // MRZ area
        let mrzArea = width / 2.35
        path.move(to: CGPoint(x: mrzArea, y: 0))
        path.addLine(to: CGPoint(x: mrzArea, y: height))
        path.closeSubpath()
        
        // Chip border
        let chipAreaX = width / 2.25
        let chipAreaY = height / 10
        let chipWidth = width / 4.6
        let chipHeight = height / 6.5
        path.move(to: CGPoint(x: chipAreaX + 10, y: chipAreaY))
        path.addLine(to: CGPoint(x: chipAreaX + chipWidth - 10, y: chipAreaY))
        path.addArc(
            center: CGPoint(x: chipAreaX + chipWidth - 10, y: chipAreaY + 10),
            radius: 10,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: chipAreaX + chipWidth, y: chipAreaY + chipHeight - 10))
        path.addArc(
            center: CGPoint(x: chipAreaX + chipWidth - 10, y: chipAreaY + chipHeight - 10),
            radius: 10,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 90),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: chipAreaX + 10, y: chipAreaY + chipHeight))
        path.addArc(
            center: CGPoint(x: chipAreaX + 10, y: chipAreaY + chipHeight - 10),
            radius: 10,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 180),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: chipAreaX, y: chipAreaY + 10))
        path.addArc(
            center: CGPoint(x: chipAreaX + 10, y: chipAreaY + 10),
            radius: 10,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        path.closeSubpath()
        
        // Chip
        let chipBlock1AreaX = width / 2
        let chipBlock1AreaY = height / 10
        let chipBlock1AreaHeight = height / 6.5
        
        let chipBlock2AreaX = width / 1.8
        
        path.move(to: CGPoint(x: chipBlock1AreaX, y: chipBlock1AreaY))
        path.addLine(to: CGPoint(x: chipBlock1AreaX, y: chipBlock1AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock2AreaX, y: chipBlock1AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock2AreaX, y: chipBlock1AreaY))
        path.closeSubpath()
        
        let chipBlock3AreaX = width / 1.65
        path.move(to: CGPoint(x: chipBlock2AreaX, y: chipBlock1AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock3AreaX, y: chipBlock1AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock3AreaX, y: chipBlock1AreaY))
        path.addLine(to: CGPoint(x: chipBlock2AreaX, y: chipBlock1AreaY))
        path.closeSubpath()
        
        let chipBlock5AreaY = height / 3.95
        let chipBlock5AreaHeight = height / 4.9
        
        path.move(to: CGPoint(x: chipBlock1AreaX, y: chipBlock5AreaY))
        path.addLine(to: CGPoint(x: chipBlock1AreaX, y: chipBlock5AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock2AreaX, y: chipBlock5AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock2AreaX, y: chipBlock5AreaY))
        path.closeSubpath()
        
        let chipBlock6AreaX = width / 1.65
        path.move(to: CGPoint(x: chipBlock2AreaX, y: chipBlock5AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock6AreaX, y: chipBlock5AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock6AreaX, y: chipBlock5AreaY))
        path.addLine(to: CGPoint(x: chipBlock2AreaX, y: chipBlock5AreaY))
        path.closeSubpath()
        
        let chipBlock7AreaHeight = height / 5.6
        let chipBlock7AreaY = height / 4.5
        path.move(to: CGPoint(x: chipBlock1AreaX, y: chipBlock1AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock1AreaX, y: chipBlock7AreaHeight))
        path.addLine(to: CGPoint(x: chipAreaX, y: chipBlock7AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock1AreaX, y: chipBlock7AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock1AreaX, y: chipBlock7AreaY))
        path.closeSubpath()
        
        path.move(to: CGPoint(x: chipBlock3AreaX, y: chipBlock1AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock3AreaX, y: chipBlock7AreaHeight))
        path.addLine(to: CGPoint(x: chipAreaX + chipWidth, y: chipBlock7AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock3AreaX, y: chipBlock7AreaHeight))
        path.addLine(to: CGPoint(x: chipBlock3AreaX, y: chipBlock7AreaY))
        path.closeSubpath()
        
        return path
    }
    
    // MARK: - Initialization Methods
    
    public init() {
    }
}

#if DEBUG
struct IOVisionIdentityShape_Previews: PreviewProvider {
    
    struct IOVisionIdentityShapeDemo: View {
        
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    Color.black
                    IOVisionIdentityShape()
                        .stroke(Color.white)
                        .padding(64)
                        .frame(width: proxy.size.width, height: proxy.size.width * 1.4)
                }
            }
        }
    }
    
    static var previews: some View {
        IOVisionIdentityShapeDemo()
    }
}
#endif
