//
// DataRequestTests.swift
//
// Created by David Thorn
// Copyright @ 2018 David Thorn. All rights reserved
//

import XCTest
import Dispatch

@testable import DataRequest

class DataRequestTests: XCTestCase {
   
   func testOptionalConstructor() {

       let urlString = "https://github.com/davidthorn"

       let data = DataRequest(urlString: urlString)

       XCTAssertNotNil(data , "The data request object should not be nil")

   }

    /// Test that the URLSessions extension method returns a response
    /// from the request to github
    /// Because we know that the url is valid it should return a statCode of 200 and the content should be html
    /// If this fails then the connection was bad or my account does not exist any futher
   func testURLSessionExtension() {

        var asyncResult: Bool = false

        let url = URL(string: "https://github.com/davidthorn")!

        let request = URLRequest(url: url)

        let group = DispatchGroup()

        let session = URLSession(configuration: URLSessionConfiguration.default)

        group.enter()
        
        session.dataTask(with: request) { result in
           
            asyncResult = true
           
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
            group.leave()
        }

       group.wait()

       XCTAssertEqual(asyncResult , true , "the result should have been changed in the data task callback")

   }

   func testDataRequest() {

        var asyncResult: Bool = false

        let url = URL(string: "https://github.com/davidthorn")!

        let group = DispatchGroup()

        let session = DataRequest(url: url)

        group.enter()
        
        session.data { result in
           
            asyncResult = true
           
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
            group.leave()
        }

       group.wait()

       XCTAssertEqual(asyncResult , true , "the result should have been changed in the data task callback")
 

   }

    func testDataRequestSync () {

        let url = URL(string: "https://github.com/davidthorn")!
    
        let dataRequest = DataRequest(url: url)

        let result = dataRequest.sync

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

    }

    func testUrlExtension() {
        
        let url = URL(string: "https://github.com/davidthorn")!
    
        let result = url.sync

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


    }

    func testUrlSyncCallbackIsSynchronous() {

        var sum: Int = 1

        let url = URL(string: "https://github.com/davidthorn")!
    
        url.sync { _ in
            sum += 1
        }

        XCTAssertEqual(sum , 2 , "the sum must have been incremented in the callback")

    }

    func testUrlASyncCallbackIsAsynchronous() {
        
        let group = DispatchGroup()

        var sum: Int = 1

        let url = URL(string: "https://github.com/davidthorn")!
    
        group.enter()
        url.async { _ in
            sum += 1
            group.leave()
        }

        group.wait()
        XCTAssertEqual(sum , 2 , "the sum must have been incremented in the callback")

    }

    static var allTests = [
        ("Test that the optional constructor returns a data request with valid url string", testOptionalConstructor),
        ("Test URL Session works" , testURLSessionExtension),
        ("Test Data Request works" , testDataRequest),
        ("Test Data Request works synchronously" , testDataRequestSync),
        ("Test URL Extension works" , testUrlExtension),
        ("Test that the sync callback for URL is actually in sync" , testUrlSyncCallbackIsSynchronous),
        ("Test that the URL async callback is actually asnyc called " , testUrlASyncCallbackIsAsynchronous),
    ]
}
