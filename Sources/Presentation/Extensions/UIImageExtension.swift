//
//  UIImageExtension.swift
//  SevenK
//
//  Created by Adnan ilker Ozcan on 20.12.2020.
//  Copyright © 2020 Ilker OZCAN. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
	
	func portraitImage() -> UIImage {
		let orientation = self.imageOrientation
		
		if orientation == .up {
			return self
		}
		
		let rotation: CGAffineTransform!
		if orientation == .left {
			rotation = CGAffineTransform(rotationAngle: (-90 * CGFloat.pi / 180))
		} else if orientation == .right {
			rotation = CGAffineTransform(rotationAngle: (90 * CGFloat.pi / 180))
		} else if orientation == .down {
			rotation = CGAffineTransform(rotationAngle: (180 * CGFloat.pi / 180))
		} else {
			rotation = nil
		}
		
		let cgImageOrientation = CGImagePropertyOrientation(rawValue: UInt32(orientation.rawValue))!
		guard let ciImage = CIImage(image: self)?.oriented(cgImageOrientation) else { return self }
		
		let outputImage = ciImage.transformed(by: rotation)
		guard let rotatedImage = CIContext().createCGImage(outputImage, from: outputImage.extent) else { return self }
		
		let returnImage = UIImage(cgImage: rotatedImage)
		return returnImage
	}
}
