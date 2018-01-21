import Dispatch
import Foundation


extension  DataRequest {
    
    public static func loadSync(url urlString: String) -> Any? {

        var data: Any? = nil

        var error: Error? = nil

        self.dispatchGroup.enter()

        let item = DispatchWorkItem {

            JSONRequest.rawValue(url: urlString) { result in

                switch result  {
                    case .success(let rawValue):

                    data = rawValue

                    case .fail(let _error):
                        error = _error
                        
                }

                self.dispatchGroup.leave()

            }?.resume()
        }

        self.dispatchQueue.async(execute: item)

        self.dispatchGroup.wait()

        guard error == nil , let loadedData = data else {
            return nil
        }

        return loadedData
    }
    
}
 