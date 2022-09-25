//
//  InteractorExtension.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.09.2022.
//

import Foundation
import IOSwiftUIPresentation

public extension IOInteractor {
    
    // MARK: - Indicator
    
    func showIndicator() {
        self.presenter?.showIndicator()
    }
    
    func hideIndicator() {
        self.presenter?.hideIndicator()
    }
}
