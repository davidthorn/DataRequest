//
// DataRequestResult.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import Foundation

public enum DataRequestResult {

    case success(Data, URLResponse)
    
    case fail(Error)

    var value: Data? {
        switch self {
            case .success(let result , _): return result
            default: return nil
        }
    }
}