import Foundation
import Dispatch

extension DataRequest {

    internal static var dispatchQueueName: String {
        return "davidthorn.dataRequest.load.sync"
    }

    internal static var dispatchGroup: DispatchGroup {

            guard let group = self._dispatchGroup else {
                self._dispatchGroup = DispatchGroup()
                return self._dispatchGroup!
            }

            return group

    } 

    internal static var dispatchQueue: DispatchQueue {

            guard let queue = self._dispatchQueue else {
                self._dispatchQueue = DispatchQueue(label: dispatchQueueName , attributes: .concurrent)
                return self._dispatchQueue!
            }

            return queue

    } 

}
