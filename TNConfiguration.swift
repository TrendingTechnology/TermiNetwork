// TNEnvironment.swift
//
// Copyright © 2018-2020 Vasilis Panagiotopoulos. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in the
// Software without restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

public struct TNRequestConfiguration {
    public var cachePolicy: URLRequest.CachePolicy?
    public var timeoutInterval: TimeInterval?
    public var requestBodyType: TNRequestBodyType?
    public var certificateData: NSData?

    public static let `default` = TNRequestConfiguration(cachePolicy: .useProtocolCachePolicy,
                                                             timeoutInterval: 60,
                                                             requestBodyType: .xWWWFormURLEncoded)

    public init() { }

    public init(cachePolicy: URLRequest.CachePolicy?,
                timeoutInterval: TimeInterval?,
                requestBodyType: TNRequestBodyType?,
                certificateName: String? = nil) {
        self.cachePolicy = cachePolicy ?? TNRequestConfiguration.default.cachePolicy
        self.timeoutInterval = timeoutInterval ?? TNRequestConfiguration.default.timeoutInterval
        self.requestBodyType = requestBodyType ?? TNRequestConfiguration.default.requestBodyType
        
        if let certPath = Bundle.main.path(forResource: certificateName, ofType: "cer"),
            let certData = NSData(contentsOfFile: certPath) {
            self.certificateData = certData
        }
    }

    public init(cachePolicy: URLRequest.CachePolicy?) {
        self.init(cachePolicy: cachePolicy, timeoutInterval: nil, requestBodyType: nil)
    }
    public init(timeoutInterval: TimeInterval?) {
        self.init(cachePolicy: nil, timeoutInterval: timeoutInterval, requestBodyType: nil)
    }
    public init(requestBodyType: TNRequestBodyType?) {
        self.init(cachePolicy: nil, timeoutInterval: nil, requestBodyType: requestBodyType)
    }
}
