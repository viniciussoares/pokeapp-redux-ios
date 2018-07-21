import UIKit
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let appContainer = AppContainer()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        initMainScreen()
        return true
    }

    private func initMainScreen() {
        let navigationController = appContainer.resolve(UINavigationController.self)
        navigationController.isNavigationBarHidden = true

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        let pokemonsController = PokemonsController()
        navigationController.viewControllers = [pokemonsController]
    }
}
