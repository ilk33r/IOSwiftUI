//
//  IOSwiftUINFCParserTests.swift
//  
//
//  Created by Adnan ilker Ozcan on 21.12.2022.
//

import XCTest
@testable import IOSwiftUISupportNFC
@testable import IOSwiftUIInfrastructure

final class IOSwiftUINFCParserTests: XCTestCase {
    
    func testComParser() throws {
        let comData = Data(fromHexString: "60185f0104303130375f36063034303030305c066175656b6c6f")
        
        let comModel = try IOISO7816DGComModel(data: comData)
        XCTAssertEqual(comModel.version, "0107")
        XCTAssertEqual(comModel.unicodeVersion, "040000")
        
        XCTAssertNotNil(comModel.dataGroups.first(where: { $0 == .dg1 }))
        XCTAssertNotNil(comModel.dataGroups.first(where: { $0 == .dg2 }))
        XCTAssertNotNil(comModel.dataGroups.first(where: { $0 == .dg5 }))
        XCTAssertNotNil(comModel.dataGroups.first(where: { $0 == .dg11 }))
        XCTAssertNotNil(comModel.dataGroups.first(where: { $0 == .dg12 }))
        XCTAssertNotNil(comModel.dataGroups.first(where: { $0 == .dg15 }))
    }
}
