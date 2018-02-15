//
//  APIFoodRouter.swift
//  SimpleNetworking_Example
//
//  Created by Vasilis Panagiotopoulos on 15/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SimpleNetworking

enum APIFoodRouter: SNRouteProtocol {
    // Define your routes
    case categories
    
    // Set method, path, params, headers for each route
    internal func construct() -> SNRouteReturnType {
        switch self {
        case .categories:
            return (
                method: .get,
                path: path("categories.php"),
                params: nil,
                headers: nil
            )
        }
    }
    
    // Create static helper functions for each route
    static func getCategories(onSuccess: @escaping SNSuccessCallback<FoodRootClass>, onFailure: @escaping SNFailureCallback) {
        try? SNCall(route: APIFoodRouter.categories).start(onSuccess: onSuccess, onFailure: onFailure)
    }
}
