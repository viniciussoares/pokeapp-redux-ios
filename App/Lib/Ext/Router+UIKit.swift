import UIKit

extension UIViewController {
    func navigate(_ navigation: Navigation) {
        container.resolve(Router.self).navigate(navigation, from: self)
    }
}

extension UIView {
    func navigate(_ navigation: Navigation) {
        if let controller = UIApplication.shared.keyWindow?.rootViewController {
            container.resolve(Router.self).navigate(navigation, from: controller)
        }
    }
}
