import Swinject
import UIKit

extension UIApplication {
    static var container: Container {
        if let delegate = shared.delegate as? AppDelegate {
            return delegate.container
        }
        fatalError("Unknown AppDelegate")
    }
}
