import UIKit

struct AppNavigation: AppNavigationType {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        return UIViewController()
    }

    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
}
