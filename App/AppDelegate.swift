import UIKit
import ReSwift

let store: Store<AppState> = Store<AppState>(reducer: appReducer, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let navigationController = UINavigationController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        initMainScreen()
        return true
    }

    private func initMainScreen() {
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        navigationController.isNavigationBarHidden = true

        let pokemonsController = PokemonsController()
        navigationController.viewControllers = [pokemonsController]
    }
}
