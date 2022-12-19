//
//  IONFCTagReader.swift
//  
//
//  Created by Adnan ilker Ozcan on 18.12.2022.
//

import Foundation
import IOSwiftUIInfrastructure

public protocol IONFCTagReader {
    
    // MARK: - Defs
    
    typealias DataGroupHandler = (_ dg: IONFCDataGroup, _ data: Data) -> Void
    typealias ErrorHandler = (_ error: IONFCError) -> IOLocalizationType
    typealias FinishHandler = () -> Void
    typealias StatusHandler = (_ status: IONFCReaderStatus) -> IOLocalizationType
    
    // MARK: - Initialization Methods
    
    init(dataGroups: [IONFCDataGroup])
    
    // MARK: - Reader Methods
    
    func startScanning(data: IONFCTagReaderData) throws
    func stopScanning()
    
    // MARK: - Handlers
    
    func dataGroup(handler: @escaping DataGroupHandler)
    func error(handler: @escaping ErrorHandler)
    func finish(handler: @escaping FinishHandler)
    func status(handler: @escaping StatusHandler)
}
