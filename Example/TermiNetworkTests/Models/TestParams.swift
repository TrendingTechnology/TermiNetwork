//
//  TestParams.swift
//  TermiNetworkTests
//
//  Created by Vasilis Panagiotopoulos on 06/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

struct TestParam: Codable {
    
    let param1 : String
    let param2 : String
    let param3 : String
    let param4 : String
    let param5 : String?

    enum CodingKeys: String, CodingKey {
        case param1 = "key1"
        case param2 = "key2"
        case param3 = "key3"
        case param4 = "key4"
        case param5 = "key5"
    }
}
