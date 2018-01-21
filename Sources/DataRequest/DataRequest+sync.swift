import Foundation
import Dispatch

extension DataRequest {

     public static func sync(url urlString: String) throws -> Data {

        var data: Data!

        var _error: Error? = nil

        self.dispatchGroup.enter()

        let item = DispatchWorkItem {

            DataRequest.from(url: urlString) { result in
                
                switch result  {
                    case .success(let rawValue):

                    data = rawValue

                    case .fail(let error):
                        _error =  error
                        
                }

                self.dispatchGroup.leave()

            }?.resume()
            
        }

        self.dispatchQueue.async(execute: item)

        self.dispatchGroup.wait()

        guard _error == nil else {
            throw _error!
        }

        guard let loadedData = data else {
            throw DataRequestError.dataNil
        }

        return loadedData
    }
}

