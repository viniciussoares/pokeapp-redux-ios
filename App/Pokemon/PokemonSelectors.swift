import ReSwift
import RxSwift
import Data

final class PokemonSelectors {
    private lazy var store = UIApplication.container.resolve(AppStore.self)!

    var isFetching: Bool {
        return store.state.pokemonState.isFetching
    }

    func hasCache(for id: String) -> Bool {
        return store.state.pokemonState.byId[id] != nil
    }

    func observePokemon(id: String) -> Observable<Pokemon> {
        return store.asObservable().map { $0.pokemonState.byId[id] }.distinctUntilChanged().unwrap()
    }

    func observeIsFetching() -> Observable<Bool> {
        return store.asObservable().map { $0.pokemonState.isFetching }.distinctUntilChanged()
    }

    func observeError() -> Observable<Error?> {
        return store.asObservable().map { $0.pokemonState.error }
    }
}
