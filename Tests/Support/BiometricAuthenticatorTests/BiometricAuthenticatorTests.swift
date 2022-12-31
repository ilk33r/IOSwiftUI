//
//  BiometricAuthenticatorTests.swift
//  
//
//  Created by Adnan ilker Ozcan on 25.12.2022.
//

import LocalAuthentication
import XCTest
@testable import IOSwiftUISupportBiometricAuthenticator
import IOSwiftUIInfrastructure
import IOSwiftUICommonTests

final class BiometricAuthenticatorTests: XCTestCase {

    private let user = "testUser"
    
    private var authenticator: IOBiometricAuthenticator!
    
    override func setUp() {
        super.setUp()
        
        IOTestAssembly.configureDI(container: IODIContainerImpl.shared)
        self.authenticator = IOBiometricAuthenticator()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateKey() throws {
        let status = try? self.authenticator.checkBiometricStatus()
        XCTAssertNil(status)
    }
    
    /*
    func testSignData() throws {
        let dataForSign = Data([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F])
        let signedData = try IOBiometricAuthenticatorKeyUtilities.sign(dataForSign, forTag: self.keyTag)
        IOLogger.verbose(signedData.toHexString())
        XCTAssertGreaterThan(signedData.count, 0)
    }
    
    func testDeleteKey() throws {
        try IOBiometricAuthenticatorKeyUtilities.delete(forTag: self.keyTag)
    }
     */

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
