import ReSwift
import RxSwift
import Data

final class PokemonsSelectors: ContainerProvider {
    private lazy var store = container.resolve(AppStore.self)

    var pokemons: [Pokemon] {
        return store.state.pokemonsState.pokemons
    }

    var isFetching: Bool {
        return store.state.pokemonsState.isFetching
    }

    var error: Error? {
        return store.state.pokemonsState.error
    }

    func observePokemons() -> Observable<[Pokemon]> {
        return store.asObservable().map { $0.pokemonsState.pokemons }.distinctUntilChanged()
    }

    func observeIsFetching() -> Observable<Bool> {
        return store.asObservable().map { $0.pokemonsState.isFetching }.distinctUntilChanged()
    }

    func observeError() -> Observable<Error?> {
        return store.asObservable().map { $0.pokemonsState.error }
    }
}
