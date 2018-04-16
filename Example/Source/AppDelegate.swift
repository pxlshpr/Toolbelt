import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var navigation: Navigation?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.navigation = Navigation(window: window)
    self.window = window
    self.navigation?.start()
    return true
  }
}

class Navigation {
  let viewController: UIViewController
  
  init(window: UIWindow) {
    self.viewController = ViewController()
    window.rootViewController = self.viewController
    window.makeKeyAndVisible()
  }
  
  func start() {
  }
}
