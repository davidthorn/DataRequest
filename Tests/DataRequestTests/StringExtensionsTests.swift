//
// StringExtensionsTests.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import XCTest
import Dispatch

@testable import DataRequest

class StringExtensionsTests: XCTestCase {
   
    func testInvalidUrlStringProducesError() {

        let urlStringResult = "some invalid string".syncURLRequest

        XCTAssertNil(urlStringResult.value , "the value must be nil because the url in invalid")

        switch urlStringResult {
            case .success(_,_):
            XCTFail("This result must not be successful, due to the url string being invalid")
            default: break
        }

    }
    
    func testStringSyncRequest()  {

        let urlString = "github.com/davidthorn"
    
        let result = urlString.syncURLRequest

        switch result {
            case .success(let data , let response):
                XCTAssert(data.count > 0 )

                let string = String(data: data , encoding: .utf8)
                XCTAssertNotNil(string , "the data should have been convert to a string")
                
                let httpResponse = response as? HTTPURLResponse
                XCTAssertNotNil(httpResponse , "the http response must not be nil")
                XCTAssertEqual(httpResponse!.statusCode , 200 , "the status code should  equal 200")

            case .fail(let error):
                XCTFail(error.localizedDescription)
        }

        XCTAssertNotNil(result.value , "The data object should not be nil")
    
    }

    func testStringSyncStreamLine() {

        let data = "github.com/davidthorn".syncURLRequest.value

        XCTAssertNotNil(data , "the data must not be nil")

    }

    func testStringSyncStreamLineWithoutHttpsInString() {

        let data = "github.com/davidthorn".syncURLRequest.value

        XCTAssertNotNil(data , "the data must not be nil")

    }

    static var allTests = [
        (
            "Test that an invalid url string will produce an error and return value of nil", 
            testInvalidUrlStringProducesError
        ),
        (
            "Test that a sync url request can be completed on a string",
            testStringSyncRequest
        ),
        (
            "Test that the sync url call from a string can be completed synchcronously in a single line",
            testStringSyncStreamLine
        ),
        (
            "Test that the string does not require for https:// to be added",
            testStringSyncStreamLineWithoutHttpsInString
        )
    ]
}
