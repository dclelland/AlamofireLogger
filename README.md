# AlamofireLogger

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AlamofireLogger.svg)](https://img.shields.io/cocoapods/v/AlamofireLogger.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/Alamofire.svg?style=flat)](https://alamofire.github.io/Alamofire)

Tiny Alamofire plugin that logs requests and responses.

### Examples

✓ Real, real simple, just prints the HTTP method/status code alongside the URL

```swift

Alamofire.request("http://myapi.com/users").log().responseJSON { response in
    print(response)
}

// GET http://myapi.com/users
// 200 http://myapi.com/users

```

✓ Print response bodies, too

```swift

Alamofire.request("http://myapi.com/users").log(.verbose).responseJSON { response in
    print(response)
}

// GET http://myapi.com/users
// 200 http://myapi.com/users: "[{"id": "1", "name": "Ricky"}]"

```

✓ Different logging levels for requests and responses (e.g. you might only want to print the body of your requests)

```swift

Alamofire.request(.put, "http://myapi.com/user/1", parameters: ["name": "Julian"])
    .logRequest(.verbose)
    .logResponse(.simple)
    .responseJSON { response in
        print(response)
}

// PUT http://myapi.com/user/1: "{"name":"Julian"}"
// 200 http://myapi.com/user/1

```

### Wishlist

- Additional verbosity levels, formatting options
- Pretty-printed JSON
- Protocol-oriented logger types
