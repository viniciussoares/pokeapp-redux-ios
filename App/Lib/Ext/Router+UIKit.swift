import UIKit

extension UIViewController {
    func navigate(_ navigation: Navigation) {
        UIApplication.container.resolve(Router.self)!.navigate(navigation, from: self)
    }
}

extension UIView {

    private var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self

        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }

        return nil
    }

    func navigate(_ navigation: Navigation) {
        if let controller = parentViewController {
            UIApplication.container.resolve(Router.self)!.navigate(navigation, from: controller)
        }
    }
}
