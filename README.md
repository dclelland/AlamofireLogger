# AlamofireLogger

Tiny Alamofire plugin that logs requests and responses. Uses the [Apple unified logging system](https://developer.apple.com/documentation/os/logging) to persist logs if necessary.

Cocoapods: `pod 'AlamofireLogger', '~> 1.0'`

✓ Simple installation

```swift
import AlamofireLogger

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityLogManager.shared.level = .simple
        return true
    }

}
```

✓ Custom formatters

```swift
NetworkActivityLogManager.shared.level = .custom(
    startFormatter: { request in
        return .debug("Request started: \(request.description)")
    },
    stopFormatter: { request in
        if let error = request.error {
            return .error("Request failed: \(error.localizedDescription)")
        } else {
            return .debug("Request completed: \(request.description)")
        }
    }
)
```
