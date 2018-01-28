//
// String+extensions.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import Foundation

extension String {

    /// Returns a DataRequestResult based upon the Strings value
    /// The DataRequest is executed in sync on the same calling thread
    ///
    /// - Returns: DataRequestResult
    public var syncURLRequest: DataRequestResult {

        guard let dataRequest = DataRequest(urlString: asSecureURLString) else {
            return .fail(DataRequestError.invalidUrl)
        }

        return dataRequest.sync
    }

    /// Executes a DataRequest Task synchronously on the same thread returning the DataRequestResult
    /// by calling the completion handler provided
    ///
    /// - Parameters:
    ///     - completion: @escaping (DataRequestResult) -> Void
    public func urlSyncRequest(_ completion: @escaping (DataRequestResult) -> Void ) {
        completion(self.syncURLRequest)
    }

    /// Executes a DataRequest Task Asynchronously on a concurrent background thread
    /// returning the DataRequestResult by calling the completion handler provided
    ///
    /// - Parameters:
    ///     - completion: @escaping (DataRequestResult) -> Void
    public func urlAsyncRequest(_ completion: @escaping (DataRequestResult) -> Void ) {
        
        guard let dataRequest = DataRequest(urlString: asSecureURLString) else {
            return completion(.fail(DataRequestError.invalidUrl))
        }
        
        dataRequest.data { result in
            completion(result)
        }

    }

    /// Converts the string to use a https:// protocol is it is not already present
    public var asSecureURLString: String {
        
        var urlString = self

        if !urlString.contains("https://") {
            urlString = "https://\(urlString)"
        }

        return urlString
    }

}