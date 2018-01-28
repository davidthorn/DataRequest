//
// DataRequestResult.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import Foundation

public enum DataRequestResult {

    /// The DataTask was successfull
    case success(Data, URLResponse)
    
    case fail(Error)

    public var value: Data? {
        switch self {
            case .success(let result , _): return result
            default: return nil
        }
    }
}