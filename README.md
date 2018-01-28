# DataRequest

// a description goes here


# Topics

* [Requirements](#requirements)

* [Installation](#installation)
  * [CocoaPods](#cocoapods)
  * [Carthage](#carthage)
  * [Swift Package Manager](#swift-pm)

* [Usage](#usage)

  *[Importing the package into your ViewController](#item1)

* [References](#references)

# Requirements<a name="requirements"/>

* Xcode 9.2
* Minimum iOS Deploment Target 9.0
* Swift 4.0

# Installation<a name="installation"/>

`DataRequest` doesn't contain any external dependencies.

These are currently the supported options:

# [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)<a name="cocoapods"/>

**Tested with `pod --version`: `1.3.1`**

```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'DataRequest'
end

target 'YOUR_TESTING_TARGET' do
    pod 'DataRequest'
end

```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
```

# [Carthage](https://github.com/Carthage/Carthage)<a name="carthage"/>

**Tested with `carthage version`: `0.26.2`**

Add this to `Cartfile`

```
git "https://github.com/davidthorn/DataRequest.git"
```

```bash
$ carthage update
```

# [Swift Package Manager](https://github.com/apple/swift-package-manager) <a name="swift-pm"/>

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

# Usage<a name="usage"/>


## References<a name="references"/>
