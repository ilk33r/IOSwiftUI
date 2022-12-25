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
import IOSwiftUISupportNFC

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
    
    func parseNFCDG(dg: IONFCISO7816DataGroup, data: Data) {
        if dg == .dg1 {
            self.parseNFCDG1(data: data)
        } else if dg == .dg2 {
            self.parseNFCDG2(data: data)
        } else if dg == .dg11 {
            self.parseNFCDG11(data: data)
        }
    }
    
    func parseNFCDG1(data: Data) {
        do {
            let dg1 = try IOISO7816DG1Model(data: data)
            appState.set(object: dg1, forType: .registerNFCDG1)
        } catch {
            presenter?.updateError()
        }
    }
    
    func parseNFCDG2(data: Data) {
        do {
            let dg2 = try IOISO7816DG2Model(data: data)
            appState.set(object: dg2, forType: .registerNFCDG2)
        } catch {
            presenter?.updateError()
        }
    }
    
    func parseNFCDG11(data: Data) {
        do {
            let dg11 = try IOISO7816DG11Model(data: data)
            appState.set(object: dg11, forType: .registerNFCDG11)
        } catch {
            presenter?.updateError()
        }
    }
}
