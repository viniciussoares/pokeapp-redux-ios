import UIKit

extension UIViewController {
    func navigate(_ navigation: Navigation) {
        container.resolve(Router.self).navigate(navigation, from: self)
    }
}
