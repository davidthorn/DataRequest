import DataRequest
import Dispatch
import Foundation

DataRequest.accessToken = "enter token here"
/*
do {

    let data = try DataRequest.sync(url:  "https://api.github.com/users/davidthorn/repos" )

    let string = String(data:data , encoding: .utf8)!

    print(string)

} catch  let error {

    print(error)

}*/
/*
guard let data = DataRequest.loadSync(url: "https://api.github.com/users/davidthorn/repos") else {
    print("no data returned")
    exit(2)
}
*/
//  print(data)