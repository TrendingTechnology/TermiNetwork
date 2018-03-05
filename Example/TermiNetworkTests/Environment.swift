//
//  Environment.swift
//  TermiNetworkTests
//
//  Created by Vasilis Panagiotopoulos on 05/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import TermiNetwork

enum Environment: TNEnvironmentProtocol {
    case httpHost
    case httpHostWithPort
    case httpHostWithPortAndSuffix
    case httpsHostWithPortAndSuffix
    
    func configure() -> TNEnvironment {
        switch self {
        case .httpHost:
            return TNEnvironment(scheme: .http, host: "localhost")
        case .httpHostWithPort:
            return TNEnvironment(scheme: .http, host: "localhost", suffix: nil, port: 8080)
        case .httpHostWithPortAndSuffix:
            return TNEnvironment(scheme: .http, host: "localhost", suffix: path("v1", "json"), port: 8080)
        case .httpsHostWithPortAndSuffix:
            return TNEnvironment(scheme: .https, host: "google.com", suffix: path("v3", "test", "foo", "bar"), port: 8080)
            
        }
    }
}
