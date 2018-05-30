//
//  TestTNQueue.swift
//  TermiNetworkTests
//
//  Created by Vasilis Panagiotopoulos on 30/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import TermiNetwork

class TestTNQueue: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        TNEnvironment.set(Environment.termiNetworkRemote)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQueue() {
        var numberOfRequests = 8
        let queue = TNQueue()
        let expectation = XCTestExpectation(description: "Test queue")

        TNCall.afterAllRequestsBlock = {
            expectation.fulfill()
        }
        
        for _ in 1...8 {
            try? TNCall(method: .get, url: "http://google.com", params: nil).start(queue: queue, onSuccess: { _ in
                numberOfRequests -= 1
            }) { error, data in
                numberOfRequests -= 1
            }
        }
        
        
        wait(for: [expectation], timeout: 10)

        XCTAssert(numberOfRequests == 0)
    }
}
