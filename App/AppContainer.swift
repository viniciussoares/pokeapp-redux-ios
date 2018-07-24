import Swinject
import ReSwift
import Data

final class AppContainer {
    fileprivate let container = Container()

    init(mock: Bool = false) {
        if mock { return }
        registerSingletons()
    }

    private func registerSingletons() {
        container.register(UINavigationController.self) { _ in UINavigationController() }
            .inObjectScope(.container)

        container.register(AppStore.self) { _ in AppStore(reducer: appReducer, state: nil) }
            .inObjectScope(.container)

        container.register(Router.self) { _ in DefaultRouter(appNavigation: AppNavigation()) }
            .inObjectScope(.container)

        container.register(PokemonRepository.self) { _ in DefaultPokemonRepository() }
            .inObjectScope(.container)
    }

}

extension AppContainer {
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType, name: nil)!
    }
}
