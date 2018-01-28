# DataRequest

The framework is designed to reduce the amount of repeative boiler plate code which is required to make a URLSession request for a url string.

By using this framework you can really go from writing 20 lines of code to basically one if you are only interested in the Data which returns from the request.

# Topics

* [Requirements](#requirements)

* [Installation](#installation)
  * [Carthage](#carthage)
  * [Swift Package Manager](#swift-pm)

* [Usage](#usage)
  
  * [Create DataRequest instance using a String](#item1)
  * [Create DataRequest instance using a URL](#item2)
  * [Inferring URL is secure](#item3)
  * [Using DataRequestResult](#item4)
  * [Asynchronous Data Request with completion handler](#item5)
  * [Asynchronous DataRequest using the value property of DataRequestResult](#item6)
  * [Synchronous DataRequest ](#item7)
  * [Optional Data using Synchronous DataRequest](#item8)
  * [String's Extensions](#item9)
  * [URL's Extensions](#item10)
  
* [References](#references)

<a name="requirements"></a>

# Requirements

* Xcode 9.2
* Minimum iOS Deploment Target 9.0
* Swift 4.0

<a name="installation"></a>

# Installation

<a name="carthage"></a>

# [Carthage](https://github.com/Carthage/Carthage)

**Tested with `carthage version`: `0.26.2`**

Add this to `Cartfile`

```
git "https://github.com/davidthorn/DataRequest.git"
```

```bash
$ carthage update
```

 <a name="swift-pm"></a>

# [Swift Package Manager](https://github.com/apple/swift-package-manager)

**Tested with `swift build --version`: `Swift 4.0.0-dev (swiftpm-13126)`**

Create a `Package.swift` file.

```swift

// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PACKAGE_NAME",
    dependencies: [
        .package(url: "https://github.com/davidthorn/DataRequest.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "PACKAGE_NAME", dependencies: [
        "DataRequest"
        ])
    ]
    )

```

```bash
$ swift build

```

<a name="usage"></a>

# Usage

## Create DataRequest instance using a String <a name="item1"/>

```swift
/// Creates an optional DataRequest object
let dataRequest: DataRequest? = DataRequest(urlString: "https://github.com/davidthorn/DataRequest.git")
```

 <a name="item2"></a>

## Create DataRequest instance using a URL

```swift
let url = URL(string: "https://github.com/davidthorn/DataRequest.git")
let dataRequest: DataRequest = DataRequest(url: url)
..
```
<a name="item3"></a>

## Inferring URL is secure 

The `https://` scheme can be left out of the url because it will be inferred that this is a secure request.

```swift
let url = URL(string: "github.com/davidthorn/DataRequest.git")
let dataRequest: DataRequest = DataRequest(url: url)
..
```

 <a name="item4"></a>

## Using `DataRequestResult`

All methods in the `DataRequest` framework will return a `DataRequestResult`.

A `DataRequestResult` is an enum containing 2 possible responses:

```swift
public enum DataRequestResult {
    // Used only if the data request returns Data and a URLResponse
    case success(Data, URLResponse)
    /// Used for all other situations where success is not used
    case fail(Error)
}
```

<a name="item5"></a>

## Asynchronous Data Request with completion handlers DataRequestResult 

In this example the DataRequestResult has been used with a `switch` case.

```swift
import Foundation
import DataRequest

let dataRequest = DataRequest(urlString: "github.com/davidthorn/DataRequest.git")

dataRequest.data { (result: DataRequestResult) in
    switch result {
        case .success(let data: Data , let response: URLResponse):
            // use the data
        case .fail(let error):
            // an error has occurred
    }

}
```

<a name="item6"></a>

## Asynchronouse DataRequest using the value property of DataRequestResult

If you are not interested in handling the error case, then you can access the `value: Data?` property of 
the `DataRequestResult` directly

```swift
import Foundation
import DataRequest

let dataRequest = DataRequest(urlString: "github.com/davidthorn/DataRequest.git")

dataRequest.data { (result: DataRequestResult) in
    // check if the result has data if so then the it will return here with a value
    guard let data: Data = result.value else { return }

}
```

<a name="item7"></a>

## Synchronous DataRequest 

If this request should be completed synchronously then you can use the `sync` property of the `DataRequest` to retrieve the `DataRequestResult`.

```swift
import Foundation
import DataRequest

let dataRequest = DataRequest(urlString: "github.com/davidthorn/DataRequest.git")
let dataResult: DataRequestResult = dataRequest.sync


```

<a name="item8"></a>

## Optional Data using Synchronous DataRequest 

Once again you can use the `value: Data?` property of the `DataRequestResult` whilst using the `sync` property of the DataRequest.

```swift
import Foundation
import DataRequest

let dataRequest: DataRequest = DataRequest(urlString: "github.com/davidthorn/DataRequest.git")

guard let data: Data = dataRequest.sync.value else {
    // not data has been return
    return
}
```

<a name="item9"></a>

# String's Extensions 

To make this process even shorter you can use the `String`'s `syncURLRequest` property to execute this DataTask inline and synchronously

```swift

import Foundation
import DataRequest

// Option 1

let dataResult: DataRequestResult = "github.com/davidthorn/DataRequest.git".syncURLRequest
let data: Data? = dataResult.value

// Option 2

let dataResult: Data? = "github.com/davidthorn/DataRequest.git".syncURLRequest.value

// Option 3 - Do the request synchronously with a completion handler

"github.com/davidthorn/DataRequest.git".urlSyncRequest { result in
    guard let data: Data? = result.value else { return }
}

// Option 3 - Do the request Asynchronously with a completion handler

"github.com/davidthorn/DataRequest.git".urlAsyncRequest { result in
    guard let data: Data? = result.value else { return }
}

```


<a name="item10"></a>

# URL's Extensions 

To make this process even shorter you can use the `URL`'s `syncURLRequest` property to execute this DataTask inline and synchronously

```swift

import Foundation
import DataRequest

let secureString = "github.com/davidthorn/DataRequest.git".asSecureURLString

let url = URL(string: secureString)!

// Option 1

let dataResult: DataRequestResult = url.sync
let data: Data? = dataResult.value

// Option 2

let dataResult: Data? = url.sync.value

// Option 3 - Do the request synchronously with a completion handler

url.sync { result in
    guard let data: Data? = result.value else { return }
}

// Option 3 - Do the request Asynchronously with a completion handler

url.async { result in
    guard let data: Data? = result.value else { return }
}

```

## References<a name="references"/>

