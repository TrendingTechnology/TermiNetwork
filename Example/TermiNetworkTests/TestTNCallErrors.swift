//
//  TestTNCallErrors.swift
//  TermiNetworkTests
//
//  Created by Vasilis Panagiotopoulos on 05/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//


import XCTest
import TermiNetwork

class TestTNCallErrors: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEnvironmentNotSet() {
        do {
            try TNCall(method: .get, url: "http://www.google.com", params: nil).start(onSuccess: { data in
                XCTAssert(false)
            }) { error, data in
                XCTAssert(false)
            }
        } catch TNRequestError.environmentNotSet {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
        
    }
}
