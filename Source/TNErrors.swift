// TNErrors.swift
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

// swiftlint:disable line_length

import Foundation

// Errors before execution of a request
public enum TNError: Error {
    case invalidURL
    case environmentNotSet
    case invalidParams
    case responseInvalidImageData
    case cannotDeserialize(Error)
    case cannotConvertToString
    case networkError(Error)
    case notSuccess(Int)
    case cancelled(Error)
    case invalidMockData(String)
}

extension TNError: LocalizedError {
    public var localizedDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The URL is invalid", comment: "TNError")
        case .environmentNotSet:
            return NSLocalizedString("Environment not set, use TNEnvironment.set(YOUR_ENVIRONMENT)", comment: "TNError")
        case .invalidParams:
            return NSLocalizedString("The parameters are not valid", comment: "TNError")
        case .responseInvalidImageData:
            return NSLocalizedString("The response data is not a valid image", comment: "TNError")
        case .cannotDeserialize(let error):
            let debugDescription = (error as NSError).userInfo["NSDebugDescription"] as? String ?? ""
            var errorKeys = ""
            if let codingPath = (error as NSError).userInfo["NSCodingPath"] as? [CodingKey] {
                errorKeys = (codingPath.count > 0 ? " Key(s): " : "") + codingPath.map({
                    $0.stringValue
                }).joined(separator: ", ")
            }
            let fullDescription = "\(debugDescription)\(errorKeys)"
            return NSLocalizedString("Cannot deserialize object: ", comment: "TNError") + fullDescription
        case .networkError(let error):
                return NSLocalizedString("Network error: ", comment: "TNError") + error.localizedDescription
        case .cannotConvertToString:
            return NSLocalizedString("Cannot convert to String", comment: "TNError")
        case .notSuccess(let code):
            return String(format: NSLocalizedString("The request didn't return 2xx status code but %i instead", comment: "TNError"), code)
        case .cancelled(let error):
            return NSLocalizedString("The request has been cancelled: ", comment: "TNError") + error.localizedDescription
        case .invalidMockData(let path):
            return String(format: NSLocalizedString("Invalid mock data file for: %@", comment: "TNError"), path)
        }
    }
}
