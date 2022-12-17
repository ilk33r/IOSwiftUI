// 
//  RegisterMRZReaderInteractor.swift
//  
//
//  Created by Adnan ilker Ozcan on 17.12.2022.
//

import Foundation
import IOSwiftUICommon
import IOSwiftUIInfrastructure
import IOSwiftUIPresentation
import SwiftUISampleAppScreensShared
import IOSwiftUISupportVisionDetectText

public struct RegisterMRZReaderInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterMRZReaderEntity!
    public weak var presenter: RegisterMRZReaderPresenter?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func parseMRZ(detectedTexts: [[String]]) {
        guard detectedTexts.count > 3 else { return }
        
        let lastIndex = detectedTexts.count - 1
        let mrzSecondLine = detectedTexts[lastIndex - 1]
        let mrzFirstLine = detectedTexts[lastIndex - 2]
        
        if let mrzModel = try? IOVisionIdentityMRZModel(firstLine: mrzFirstLine, secondLine: mrzSecondLine) {
            presenter?.update(mrz: mrzModel.modelData)
        }
    }
}
