
import Foundation

extension JSONRequest {

    public class func from(url string: String , containing key: String , completion: @escaping (Result<JSON>) -> Void ) -> URLSessionTask?  {

       return self.from(url: string) { result in
            
            guard let data = result.value else {
                completion(result)
                return
            }
            
            guard let value = data[key] as? JSON else {
                completion(.fail(JSONRequestError.doesNotContainkey))
                return
            }

            completion(.success(value))

        }

    }

}