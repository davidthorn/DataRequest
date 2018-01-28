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
                completionHandler(.fail(error!)) 
                return
            }

            guard let rawData = data, let rawResponse = response else {
                completionHandler(.fail(DataRequestError.dataNil))
                return 
            }

            completionHandler(.success(rawData , rawResponse))
            
        }

        guard let dataTask = task else {
            completionHandler(.fail(DataRequestError.dataTaskNil))
        }

        dataTask.resume()

    }

}