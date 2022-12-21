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
    
    func testDG1Parser() throws {
        // I<TURX98Y123456<12345678901<<<3201311F4201313TUR<<<<<<<<<<<4ABCDE<<FGHIJ<KLMNO<<<<<<<<<<<<
        let dg1Data = Data(fromHexString: "615D5F1F5A493C545552583938593132333435363C31323334353637383930313C3C3C3332303133313146343230313331335455523C3C3C3C3C3C3C3C3C3C3C3441424344453C3C464748494A3C4B4C4D4E4F3C3C3C3C3C3C3C3C3C3C3C3C")
        
        let dg1Model = try IOISO7816DG1Model(data: dg1Data)
        XCTAssertEqual(dg1Model.documentCode, "I")
        XCTAssertEqual(dg1Model.issuingState, "TUR")
        XCTAssertEqual(dg1Model.documentNumber, "X98Y12345")
        XCTAssertEqual(dg1Model.documentNumberCheckDigit, "6")
        XCTAssertEqual(dg1Model.optionalData1, "12345678901")
        XCTAssertEqual(dg1Model.dateOfBirth, "320131")
        XCTAssertEqual(dg1Model.sex, "F")
        XCTAssertEqual(dg1Model.dateOfExpiry, "420131")
        XCTAssertEqual(dg1Model.nationality, "TUR")
        XCTAssertEqual(dg1Model.optionalData2, "")
        XCTAssertEqual(dg1Model.surname, "ABCDE")
        XCTAssertEqual(dg1Model.name, "FGHIJ KLMNO")
        
    }
}
