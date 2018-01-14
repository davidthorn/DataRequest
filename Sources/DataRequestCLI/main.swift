import DataRequest
import Dispatch
import Foundation

DataRequest.accessToken = "enter token here"

guard let data = DataRequest.loadSync(url: "https://api.github.com/users/davidthorn/repos") else {
    print("no data returned")
    exit(2)
}

print(data)