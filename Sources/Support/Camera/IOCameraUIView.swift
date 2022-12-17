//
//  IOCameraUIView.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import UIKit

final public class IOCameraUIView: UIView {
    
    // MARK: - Constants
    
    private let cameraAppPrefPrivacy = "Privacy&path=CAMERA"
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.backgroundColor = .red
    }
}
