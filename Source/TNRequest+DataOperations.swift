//
//  TNRequest+DataOperations.swift
//  TermiNetwork
//
//  Created by Vasilis Panagiotopoulos on 28/4/20.
//  Copyright © 2020 Bill Panagiotopoulos. All rights reserved.
//

import UIKit

extension TNRequest {
    /// Adds a request to a queue and starts it's execution. The response object in success callback is of
    /// type Decodable
    ///
    /// - parameters:
    ///    - queue: A TNQueue instance. If no queue is specified it uses the default one. (optional)
    ///    - onSuccess: specifies a success callback of type TNSuccessCallback<T> (optional)
    ///    - onFailure: specifies a failure callback of type TNFailureCallback<T> (optional)
    public func start<T: Decodable>(queue: TNQueue? = TNQueue.shared,
                                    responseType: T.Type,
                                    onSuccess: TNSuccessCallback<T>?,
                                    onFailure: TNFailureCallback?) {
        currentQueue = queue ?? TNQueue.shared
        currentQueue.beforeOperationStart(request: self)

        dataTask = TNSessionTaskFactory.makeDataTask(with: self,
                                                     completionHandler: { data in
            let object: T!

            do {
                object = try data.deserializeJSONData() as T
            } catch let error {
                let tnError = TNError.cannotDeserialize(error)
                TNLog.logRequest(request: self,
                                 data: data,
                                 tnError: tnError)
                onFailure?(tnError, data)
                self.handleDataTaskFailure(withData: data,
                                           tnError: tnError)
                return
            }

            TNLog.logRequest(request: self,
                             data: data,
                             tnError: nil)
            onSuccess?(object)
            self.handleDataTaskCompleted(withData: data,
                                         tnError: nil)
        }, onFailure: { tnError, data in
            onFailure?(tnError, data)
            self.handleDataTaskFailure(withData: data,
                                       tnError: tnError)
        })

        currentQueue.addOperation(self)
    }

    /// Adds a request to a queue and starts it's execution. The response object in success callback is of type UIImage
    ///
    /// - parameters:
    ///     - queue: A TNQueue instance. If no queue is specified it uses the default one. (optional)
    ///     - onSuccess: specifies a success callback of type TNSuccessCallback<T> (optional)
    ///     - onFailure: specifies a failure callback of type TNFailureCallback<T> (optional)
    public func start<T: UIImage>(queue: TNQueue? = TNQueue.shared,
                                  responseType: T.Type,
                                  onSuccess: TNSuccessCallback<T>?,
                                  onFailure: TNFailureCallback?) {
        currentQueue = queue
        currentQueue.beforeOperationStart(request: self)

        dataTask = TNSessionTaskFactory.makeDataTask(with: self,
                                                     completionHandler: { data in
            let image = T(data: data)

            if image == nil {
                let tnError = TNError.responseInvalidImageData
                TNLog.logRequest(request: self,
                                 data: data,
                                 tnError: tnError)

                onFailure?(.responseInvalidImageData, data)
                self.handleDataTaskFailure(withData: data,
                                           tnError: tnError)
            } else {
                TNLog.logRequest(request: self,
                                 data: data,
                                 tnError: nil)
                onSuccess?(image ?? T())
                self.handleDataTaskCompleted(withData: data,
                                             tnError: nil)
            }
        }, onFailure: { tnError, data in
            onFailure?(tnError, data)
            self.handleDataTaskFailure(withData: data,
                                       tnError: tnError)
        })

        currentQueue.addOperation(self)
    }

    /// Adds a request to a queue and starts it's execution. The response object in success callback is of type String
    ///
    /// - parameters:
    ///    - queue: A TNQueue instance. If no queue is specified it uses the default one. (optional)
    ///    - onSuccess: specifies a success callback of type TNSuccessCallback<T> (optional)
    ///    - onFailure: specifies a failure callback of type TNFailureCallback<T> (optional)
    public func start(queue: TNQueue? = TNQueue.shared,
                      responseType: String.Type,
                      onSuccess: TNSuccessCallback<String>?,
                      onFailure: TNFailureCallback?) {
        currentQueue = queue
        currentQueue.beforeOperationStart(request: self)

        dataTask = TNSessionTaskFactory.makeDataTask(with: self,
                                                     completionHandler: { data in
            DispatchQueue.main.async {
                if let string = String(data: data, encoding: .utf8) {
                    TNLog.logRequest(request: self,
                                     data: data,
                                     tnError: nil)

                    onSuccess?(string)
                    self.handleDataTaskCompleted(withData: data,
                                                 tnError: nil)
                } else {
                    let tnError = TNError.cannotConvertToString
                    TNLog.logRequest(request: self,
                                     data: data,
                                     tnError: tnError)
                    onFailure?(tnError, data)
                    self.handleDataTaskFailure(withData: data,
                                               tnError: tnError)
                }

            }
        }, onFailure: { tnError, data in
            onFailure?(tnError, data)
            self.handleDataTaskFailure(withData: data,
                                       tnError: tnError)
        })

        currentQueue.addOperation(self)
    }

    /// Adds a request to a queue and starts it's execution. The response object in success callback is of type Data
    ///
    /// - parameters:
    ///     - queue: A TNQueue instance. If no queue is specified it uses the default one. (optional)
    ///     - onSuccess: specifies a success callback of type TNSuccessCallback<T> (optional)
    ///     - onFailure: specifies a failure callback of type TNFailureCallback<T> (optional)
    public func start(queue: TNQueue? = TNQueue.shared,
                      responseType: Data.Type,
                      onSuccess: TNSuccessCallback<Data>?,
                      onFailure: TNFailureCallback?) {
        currentQueue = queue
        currentQueue.beforeOperationStart(request: self)

        dataTask = TNSessionTaskFactory.makeDataTask(with: self,
                                                     completionHandler: { data in
            DispatchQueue.main.async {
                TNLog.logRequest(request: self, data: data,
                                 tnError: nil)
                onSuccess?(data)
                self.handleDataTaskCompleted(withData: data,
                                             tnError: nil)
            }
        }, onFailure: { tnError, data in
            onFailure?(tnError, data)
            self.handleDataTaskFailure(withData: data,
                                       tnError: tnError)
        })

        currentQueue.addOperation(self)
    }
}
