import Dispatch
import Foundation


extension  DataRequest {
    
    public static func loadSync(url urlString: String) -> Any? {

        var data: Any? = nil

        var error: Error? = nil

        let queue = DispatchQueue(label: "davidthorn.dataRequest.load.queue", attributes: .concurrent)

        let group = DispatchGroup()

        group.enter()

        let item = DispatchWorkItem {

            JSONRequest.rawValue(url: urlString) { result in

                switch result  {
                    case .success(let rawValue):

                    data = rawValue

                    case .fail(let _error):
                        error = _error
                        
                }

                group.leave()

            }?.resume()
        }

        queue.async(execute: item)

        group.wait()

        guard error == nil , let loadedData = data else {
            return nil
        }

        return loadedData
    }
    
}