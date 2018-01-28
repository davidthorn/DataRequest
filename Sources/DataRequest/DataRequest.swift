//
// DataRequest.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import Foundation
import Dispatch

public class DataRequest {

    /// Authorization Access Token
    /// Set in the headers as Token <accessToken> Authorization
    public static var accessToken: String?

    /// The URLRequest which the URLSessionDataTask will use to execute
    internal var request: URLRequest 

    /// The DispatchGroup which all DataRequest will be executed on
    internal var dispatchGroup: DispatchGroup

    /// The concurrent Dispatch Queue in which all DataTasks will be executed on
    internal var dispatchQueue: DispatchQueue

    /// The URLSession which will be used for all data tasks
    internal var session: URLSession {
        return URLSession(configuration: configuration)
    }

    /// The URLSessionConfiguration which will be used for a URLSession DataTasks
    /// It is set to the default configuration
    internal var configuration: URLSessionConfiguration = URLSessionConfiguration.default

    /// A convenience constructor to initiate this object with a urlString
    ///
    /// - Parameters:
    ///     - urlString: String the url string which should be used for the URL in the URLRequest
    /// - returns: nil if the urlString is invalid
    public convenience init?(urlString: String ) {
        guard let url = URL(string: urlString.asSecureURLString) else { return nil }
        self.init(url: url)
    }
    
    /// A default constructor to initiate this object with a URL
    ///
    /// - Parameters:
    ///     - URL: String the URL which is used for the URLRequest
    public init(url: URL ) {
        self.request = URLRequest(url: url)
        self.dispatchGroup = DispatchGroup()
        self.dispatchQueue = DispatchQueue(label: "davidthorn.datarequest.queue" , attributes: .concurrent)
    }

    /// Executes a URLSessionDataTask using the URLRequest which has been created in the constructor
    ///
    /// - Parameters:
    ///     - completion: @escaping (DataRequestResult) -> Void The completion handler which will be called for all events which occur
    public func data( completion: @escaping (DataRequestResult) -> Void ) {

        var internalRequest: URLRequest = self.request

        if let token = DataRequest.accessToken {
            internalRequest.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }

        session.dataTask(with: request) { result in
            switch result {
            case .success(let data , let response):
                completion(.success(data , response))
            case .fail(let error):
                completion(.fail(error))
            }
        }

    }

    /// Executes the DataTask on the same thread and returns a DataRequestResult
    ///
    /// - Returns: DataRequestResult
    public var sync: DataRequestResult {

        var result: DataRequestResult! 

        self.dispatchGroup.enter()

        self.data { syncResult in
            result = syncResult
            self.dispatchGroup.leave()
        }

        self.dispatchGroup.wait()

        return result

    }

}

