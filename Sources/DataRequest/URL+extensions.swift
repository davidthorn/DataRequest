//
// URL+extensions.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import Foundation

extension URL {

    /// Returns a DataRequestResult based upon the URL's value
    /// The DataRequest is executed in sync on the same calling thread
    ///
    /// - Returns: DataRequestResult
    public var sync: DataRequestResult {
        let dataRequest = DataRequest(url: self)
        return dataRequest.sync
    }

    /// Executes a DataRequest Task synchronously on the same thread returning the DataRequestResult
    /// by calling the completion handler provided
    ///
    /// - Parameters:
    ///     - completion: @escaping (DataRequestResult) -> Void
    public func sync(_ completion: @escaping (DataRequestResult) -> Void ) {
        completion(self.sync)
    }

    /// Executes a DataRequest Task Asynchronously on a concurrent background thread
    /// returning the DataRequestResult by calling the completion handler provided
    ///
    /// - Parameters:
    ///     - completion: @escaping (DataRequestResult) -> Void
    public func async(_ completion: @escaping (DataRequestResult) -> Void ) {
        
        let dataRequest = DataRequest(url: self)
        
        dataRequest.data { result in
            completion(result)
        }

    }

}
