import Foundation

public enum StringRequestError: Error {
    case couldNotConvertToString
}


public class StringRequest {

    public class func from( url string: String , completion: @escaping (Result<String>) -> Void ) -> URLSessionTask? {

        return DataRequest.from(url: string ) { result in 

            switch result {
                case .success(let data):

                    guard let dataString = String(data: data, encoding: .utf8) else {
                        completion(.fail(StringRequestError.couldNotConvertToString))
                        return
                    }

                    completion(.success(dataString))

                case .fail(let error): completion(.fail(error))
            }

        }

    }
}


extension String {

    public static func from( url string: String , completion: @escaping (Result<String>) -> Void ) -> URLSessionTask? {

        return StringRequest.from(url: string ) { result in
            switch result {
                case .success(let dataString): completion(.success(dataString))
                case .fail(let error ): completion(.fail(error))
            }
        }

    }

}