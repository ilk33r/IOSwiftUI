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
import IOSwiftUISupportNFC
import IOSwiftUISupportVisionDetectText
import SwiftUISampleAppScreensShared

public struct RegisterMRZReaderInteractor: IOInteractor {
    
    // MARK: - Interactorable
    
    public var entity: RegisterMRZReaderEntity!
    public weak var presenter: (any IOPresenterable)?
    
    // MARK: - Privates
    
    private var service = IOServiceProviderImpl<RegisterService>()
    
    // MARK: - Initialization Methods
    
    public init() {
    }
    
    // MARK: - Interactor
    
    func parseMRZ(detectedTexts: [[String]]) async throws -> IOVisionIdentityMRZModel {
        try await withUnsafeThrowingContinuation { continuation in
            guard detectedTexts.count > 3 else {
                continuation.resume(throwing: IOInteractorError.service)
                return
            }
            
            let lastIndex = detectedTexts.count - 1
            let mrzSecondLine = detectedTexts[lastIndex - 1]
            let mrzFirstLine = detectedTexts[lastIndex - 2]
            
            do {
                let mrzModel = try IOVisionIdentityMRZModel(firstLine: mrzFirstLine, secondLine: mrzSecondLine)
                continuation.resume(returning: mrzModel)
            } catch {
                continuation.resume(throwing: IOInteractorError.service)
            }
        }
    }
    
    func parseNFCDG(dg: IONFCISO7816DataGroup, data: Data) async throws {
        if dg == .dg1 {
            try await self.parseNFCDG1(data: data)
        } else if dg == .dg2 {
            try await self.parseNFCDG2(data: data)
        } else if dg == .dg11 {
            try await self.parseNFCDG11(data: data)
        }
    }
    
    func parseNFCDG1(data: Data) async throws {
        try await withUnsafeThrowingContinuation { continuation in
            do {
                let dg1 = try IOISO7816DG1Model(data: data)
                appState.set(object: dg1, forType: .registerNFCDG1)
                continuation.resume()
            } catch {
                continuation.resume(throwing: IOInteractorError.service)
            }
        }
    }
    
    func parseNFCDG2(data: Data) async throws {
        try await withUnsafeThrowingContinuation { continuation in
            do {
                let dg2 = try IOISO7816DG2Model(data: data)
                appState.set(object: dg2, forType: .registerNFCDG2)
                continuation.resume()
            } catch {
                continuation.resume(throwing: IOInteractorError.service)
            }
        }
    }
    
    func parseNFCDG11(data: Data) async throws {
        try await withUnsafeThrowingContinuation { continuation in
            do {
                let dg11 = try IOISO7816DG11Model(data: data)
                appState.set(object: dg11, forType: .registerNFCDG11)
                continuation.resume()
            } catch {
                continuation.resume(throwing: IOInteractorError.service)
            }
        }
    }
}
