import Foundation

public enum DataRequestError: Error {
    case invalidUrl
    case dataNil
}

public class DataRequest {

    public class func from( url string: String , completion: @escaping (Result<Data>) -> Void ) -> URLSessionTask? {

        guard let url = URL(string: string) else { 
            completion(.fail(JSONRequestError.invalidUrl))
            return nil
        }

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let request = URLRequest(url: url)

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

