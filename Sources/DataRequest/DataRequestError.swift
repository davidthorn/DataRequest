//
// DataRequest.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import Foundation

public enum DataRequestError: Error {

    /// The urlString provided in the constructor is invalid
    case invalidUrl

    /// The dataTask has returned a Data object which is nil
    case dataNil

    /// The URLSession returned a URLSessionDataTask object which is nil
    case dataTaskNil

}