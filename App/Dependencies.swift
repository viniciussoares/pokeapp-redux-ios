import Swinject
import ReSwift
import Data

func registerDependencies(_ container: Container) {
    registerSigletons(container)
}

private func registerSigletons(_ container: Container) {
    container.register(UINavigationController.self) { _ in UINavigationController() }
        .inObjectScope(.container)

    container.register(AppStore.self) { _ in AppStore(reducer: appReducer, state: nil) }
        .inObjectScope(.container)

    container.register(Router.self) { _ in DefaultRouter(appNavigation: AppNavigation()) }
        .inObjectScope(.container)

    container.register(PokemonRepository.self) { _ in DefaultPokemonRepository() }
        .inObjectScope(.container)
}
