import Foundation

public typealias JSON = [String:Any]

public enum JSONRequestError: Error {
    case invalidUrl
    case dataNil
    case notValidJsonFormat
    case doesNotContainkey
}

public class JSONRequest {

    public class func from( url string: String , completion: @escaping (Result<JSON>) -> Void ) -> URLSessionTask? {

        return DataRequest.from(url: string) { result in
            switch result {
                case .success(let jsonData):

                    do {

                        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])

                        guard let dict = json as? [String:Any] else { 
                            completion(.fail(JSONRequestError.notValidJsonFormat))
                            return 
                        } 

                        completion(.success(dict))

                    } catch let requestError {
                        completion(.fail(requestError))
                    }

                case .fail(let error): completion(.fail(error))
            }
        }

    }

    public class func arrayFrom( url string: String , completion: @escaping (Result<[JSON]>) -> Void ) -> URLSessionTask? {

        return self.rawValue(url: string) { result in

            switch result {

                case .success(let rawValue):

                    guard let dict = rawValue as? [JSON] else { 
                        completion(.fail(JSONRequestError.notValidJsonFormat))
                        return 
                    } 

                    completion(.success(dict))

                case .fail(let error):
                    completion(.fail(error))

            }

        }

    }

    public class func rawValue( url string: String , completion: @escaping (Result<Any>) -> Void ) -> URLSessionTask? {

        return DataRequest.from(url: string) { result in
            switch result {
                case .success(let jsonData):

                    do {

                        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])

                        completion(.success(json))

                    } catch let requestError {
                        completion(.fail(requestError))
                    }

                case .fail(let error): completion(.fail(error))
            }
        }

    }
}

