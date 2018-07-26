import UIKit
import ReSwift
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let container = Container()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        initDependencies()
        initMainScreen()
        return true
    }

    private func initDependencies() {
        registerDependencies(container)
    }

    private func initMainScreen() {
        let mainController = PokemonListController()

        let navigationController = container.resolve(UINavigationController.self)!
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [mainController]

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
