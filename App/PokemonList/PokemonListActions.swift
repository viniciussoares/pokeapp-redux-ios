import ReSwift
import RxSwift
import Data

protocol PokemonListActions: AutoMockable {
    func getPokemons()
}

final class DefaultPokemonListActions: PokemonListActions, ContainerProvider {
    private let bag = DisposeBag()
    private let selectors = PokemonListSelectors()

    private lazy var store = container.resolve(AppStore.self)
    private lazy var repository = container.resolve(PokemonRepository.self)

    func getPokemons() {
        if selectors.state.isFetching { return }

        store.dispatch(PokemonListActionTypes.FetchRequest())

        bag << repository.getPokemons().subscribe(onNext: {
            self.store.dispatch(PokemonListActionTypes.FetchSuccess(pokemons: $0))
        }, onError: {
            self.store.dispatch(PokemonListActionTypes.FetchError(error: $0))
        })
    }
}
