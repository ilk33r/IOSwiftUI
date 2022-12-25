//
//  IOISO7816TagReader.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import CoreNFC
import Foundation
import IOSwiftUIInfrastructure

final public class IOISO7816TagReader: NSObject, IONFCTagReader {
    
    // MARK: - DI
    
    @IOInject private var thread: IOThread
    
    // MARK: - Privates
    
    private let maxTryCount = 3
    private let nfcReaderQueueName = "com.ioswiftui.support.nfc"
    private let initialProgress = "⚫️"
    private let successProgress = "🟢"
    
    private var dataGroups: [IONFCISO7816DataGroup]
    private var nfcReaderQueue: DispatchQueue
    private var readedDataGroupCount: Int
    private var tryCount: Int
    
    private var currentStatus: IONFCReaderStatus!
    private var dataGroupHandler: DataGroupHandler?
    private var errorHandler: ErrorHandler?
    private var finishHandler: FinishHandler?
    private var mrzData: String!
    private var nfcReaderSession: NFCTagReaderSession!
    private var statusHandler: StatusHandler?
    private var tagCommunication: IOISO7816TagCommunicationUtilities!
    
    // MARK: - Initialization Methods
    
    public init(dataGroups: [any IONFCDataGroup]) {
        self.dataGroups = dataGroups as! [IONFCISO7816DataGroup]
        self.nfcReaderQueue = DispatchQueue(label: self.nfcReaderQueueName)
        self.tryCount = 0
        self.readedDataGroupCount = 0
        super.init()
    }
    
    deinit {
        self.nfcReaderSession = nil
    }
    
    // MARK: - Reader Methods
    
    public func startScanning(data: IONFCTagReaderData) throws {
        if !NFCTagReaderSession.readingAvailable {
            throw IONFCError.readingNotAvailable
        }
        
        guard let data = data as? IOISO7816ReaderData else {
            throw IONFCError.authenticationDataIsEmpty
        }
        
        self.mrzData = (data.describing as! String)
        self.nfcReaderSession = NFCTagReaderSession(pollingOption: .iso14443, delegate: self, queue: self.nfcReaderQueue)
        self.nfcReaderSession.begin()
    }
    
    public func stopScanning() {
        if self.nfcReaderSession != nil {
            self.nfcReaderSession.invalidate()
        }
        
        self.thread.runOnMainThread(afterMilliSecond: 150) { [weak self] in
            self?.nfcReaderSession = nil
        }
    }
    
    // MARK: - Handlers
    
    public func dataGroup(handler: @escaping DataGroupHandler) {
        self.dataGroupHandler = handler
    }
    
    public func error(handler: @escaping ErrorHandler) {
        self.errorHandler = handler
    }
    
    public func finish(handler: @escaping FinishHandler) {
        self.finishHandler = handler
    }
    
    public func status(handler: @escaping StatusHandler) {
        self.statusHandler = handler
    }
}

// MARK: - Reader Delegate

extension IOISO7816TagReader: NFCTagReaderSessionDelegate {
    
    public func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        self.thread.runOnMainThread { [weak self] in
            self?.update(status: .started)
        }
    }
    
    public func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        // Check reading was finished
        if self.currentStatus == .finished || self.currentStatus == .error {
            return
        }
        
        let nsError = error as NSError
        if nsError.code == NFCReaderError.Code.readerSessionInvalidationErrorUserCanceled.rawValue {
            self.thread.runOnMainThread { [weak self] in
                self?.currentStatus = .error
                self?.stopScanning()
                self?.thread.runOnMainThread { [weak self] in
                    self?.finishHandler?(false)
                }
            }
            
            return
        }
        
        if nsError.code == NFCReaderError.Code.readerSessionInvalidationErrorSessionTimeout.rawValue {
            self.thread.runOnMainThread { [weak self] in
                self?.currentStatus = .error
                self?.stopScanning()
                self?.thread.runOnMainThread { [weak self] in
                    self?.finishHandler?(false)
                }
            }
            
            return
        }
        
        self.currentStatus = .error
        self.stopScanning()
        self.thread.runOnMainThread { [weak self] in
            self?.finishHandler?(false)
        }
    }
    
    public func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        // Obtain tag
        guard let tag = tags.first else {
            self.update(error: .tagValidation)
            return
        }
        
        // Obtain ISO 7816 tag
        guard case let .iso7816(tagIso7816) = tag else {
            self.update(error: .tagValidation)
            return
        }
        
        // Connect to tag
        session.connect(to: tag) { [weak self] error in
            if let error {
                // Create an error
                self?.update(error: .tagConnection(message: error.localizedDescription))
                return
            }
            
            // Create a tag communication
            self?.tagCommunication = IOISO7816TagCommunicationUtilities(tag: tagIso7816)
            self?.authenticateNFCTag()
        }
    }
}

// MARK: - Tag Reader

extension IOISO7816TagReader {
    
    private func authenticateNFCTag() {
        // Authenticate tag
        do {
            try self.tagCommunication.authenticateTagWithMRZ(mrz: self.mrzData) { [weak self] _, error in
                if let error {
                    self?.update(error: error)
                    return
                }
                
                self?.tryCount = 0
                self?.readDGCOM()
            }
            
            return
        } catch let error {
            if let error = error as? IONFCError {
                self.update(error: error)
                return
            }
        }
        
        self.update(error: .authentication)
    }
    
    private func readDGCOM() {
        self.thread.runOnMainThread { [weak self] in
            self?.update(status: .reading)
        }
        
        self.tagCommunication.readDataGroup(type: .com) { [weak self] response, error in
            // Check reading is success
            if let error {
                if self?.tryCount ?? 0 < self?.maxTryCount ?? 0 {
                    self?.tryCount += 1
                    self?.readDGCOM()
                } else {
                    self?.update(error: error)
                }
                
                return
            }
            
            guard let data = response?.data else {
                self?.update(error: .tagResponse)
                return
            }
            
            self?.readedDataGroupCount = 0
            do {
                let dcomModel = try IOISO7816DGComModel(data: data)
                var dataGroupToRead = [IONFCISO7816DataGroup]()
                
                self?.dataGroups.forEach { dataGroup in
                    if let availableDataGroup = dcomModel.dataGroups.first(where: { $0 == dataGroup }) {
                        dataGroupToRead.append(availableDataGroup)
                    } else {
                        self?.dataGroupHandler?(dataGroup, nil)
                    }
                }
                
                self?.dataGroups = dataGroupToRead
                self?.readNextDataGroups()
            } catch {
                self?.update(error: .tagResponse)
            }
        }
    }
    
    private func readNextDataGroups() {
        // Update progress
        self.update(progressMessageIndex: self.readedDataGroupCount)
        
        // Check reading was finished
        if self.readedDataGroupCount >= self.dataGroups.count {
            self.thread.runOnMainThread { [weak self] in
                self?.update(status: .finished)
                self?.finishHandler?(true)
                self?.stopScanning()
            }
            return
        }
        
        self.tryCount = 0
        let groupType = self.dataGroups[self.readedDataGroupCount]
        self.readDataGroup(type: groupType)
    }
    
    private func readDataGroup(type: IONFCISO7816DataGroup) {
        self.tagCommunication.readDataGroup(type: type) { [weak self] response, error in
            // Check reading is success
            if let error {
                if self?.tryCount ?? 0 < self?.maxTryCount ?? 0 {
                    self?.tryCount += 1
                    self?.readDataGroup(type: type)
                } else {
                    self?.update(error: error)
                }
                
                return
            }
            
            guard let data = response?.data else {
                self?.update(error: .tagResponse)
                return
            }
            
            self?.dataGroupHandler?(type, data)
            self?.readedDataGroupCount += 1
            self?.readNextDataGroups()
        }
    }
}

// MARK: - Helper Methods

extension IOISO7816TagReader {
    
    private func update(error: IONFCError) {
        self.currentStatus = .error
        
        if let statusMessage = self.errorHandler?(error) {
            if self.nfcReaderSession != nil {
                self.nfcReaderSession.invalidate(errorMessage: statusMessage.localized)
            }
            
            self.thread.runOnMainThread(afterMilliSecond: 150) { [weak self] in
                self?.nfcReaderSession = nil
            }
            
            self.thread.runOnMainThread { [weak self] in
                self?.finishHandler?(false)
            }
        }
    }
    
    private func update(progressMessageIndex: Int) {
        var alertMessage = ""
        
        for i in 0..<self.dataGroups.count {
            if i < progressMessageIndex {
                alertMessage += self.successProgress
            } else {
                alertMessage += self.initialProgress
            }
            
            if i < self.dataGroups.count - 1 {
                alertMessage += " "
            }
        }
        
        self.nfcReaderSession.alertMessage = alertMessage
    }
    
    private func update(status: IONFCReaderStatus) {
        if
            let statusMessage = self.statusHandler?(status),
            self.nfcReaderSession != nil
        {
            self.nfcReaderSession.alertMessage = statusMessage.localized
        }
        
        self.currentStatus = status
    }
}
