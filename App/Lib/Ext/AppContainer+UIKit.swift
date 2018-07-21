import Swinject
import UIKit

protocol ContainerProvider {}

extension ContainerProvider {
    var container: AppContainer {
        if let instance = UIApplication.shared.delegate as? AppDelegate {
            return instance.appContainer
        }
        fatalError("Unknown AppDelegate")
    }
}

extension UIViewController: ContainerProvider {}
extension UIView: ContainerProvider {}
