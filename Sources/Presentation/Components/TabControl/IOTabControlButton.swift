//
//  IOTabControlButton.swift
//  
//
//  Created by Adnan ilker Ozcan on 13.11.2022.
//

import Foundation
import UIKit

final public class IOTabControlButton: UIButton {
    
    // MARK: - Theming
    
    @objc dynamic public var highligtedFont: UIFont? {
        didSet {
            self.updateFont()
        }
    }
    
    @objc dynamic public var normalFont: UIFont? {
        didSet {
            self.updateFont()
        }
    }
    
    // MARK: - Overrides
    
    public override var isHighlighted: Bool {
        didSet {
            self.updateFont()
        }
    }
    
    // MARK: - Helper Methods
    
    private func updateFont() {
        if self.isHighlighted {
            self.titleLabel?.font = self.highligtedFont
        } else {
            self.titleLabel?.font = self.normalFont
        }
    }
}
