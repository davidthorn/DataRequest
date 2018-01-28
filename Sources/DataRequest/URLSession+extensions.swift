//
// URLSession+extensions.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import Foundation

extension URLSession {

    /// Executes a URLSessionData with the provided URLRequest and returns DataRequestResult
    ///
    /// - Parameters:
    ///     - with: URLRequest
    ///     - completionHandler: @escaping (DataRequestResult) -> Void
    public func dataTask(with request: URLRequest , completionHandler: @escaping (DataRequestResult) -> Void) {

        let task: URLSessionDataTask? = self.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                return completionHandler(.fail(error!)) 
            }

            guard let rawData = data, let rawResponse = response else {
                return completionHandler(.fail(DataRequestError.dataNil))
            }

            completionHandler(.success(rawData , rawResponse))
            
        }

        guard let dataTask = task else {
<<<<<<< HEAD
            completionHandler(.fail(DataRequestError.dataTaskNil))
            return
=======
            return completionHandler(.fail(DataRequestError.dataTaskNil))
>>>>>>> ed366aa605838101fe06b13d60f5f9f457f8947a
        }

        dataTask.resume()

    }

}