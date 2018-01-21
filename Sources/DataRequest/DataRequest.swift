import Foundation
import Dispatch

public enum DataRequestError: Error {
    case invalidUrl
    case dataNil
}

public class DataRequest {

    internal static var _dispatchGroup: DispatchGroup?

    internal static var _dispatchQueue: DispatchQueue?

    public static var accessToken: String?

    public class func from( url string: String , completion: @escaping (Result<Data>) -> Void ) -> URLSessionTask? {

        guard let url = URL(string: string) else { 
            completion(.fail(JSONRequestError.invalidUrl))
            return nil
        }

        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config)

        var request = URLRequest(url: url)

        if let token = self.accessToken {
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.fail(error!)) 
                return
            }

            guard let rawData = data else {
                completion(.fail(JSONRequestError.dataNil))
                return 
            }

            completion(.success(rawData))
            
        }

        return task
    }


}

