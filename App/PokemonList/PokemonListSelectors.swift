import ReSwift
import RxSwift
import Data

final class PokemonListSelectors {
    private lazy var store = UIApplication.container.resolve(AppStore.self)!

    var state: PokemonListState {
        return store.state.pokemonListState
    }

    func observe() -> Observable<PokemonListState> {
        return store.asObservable().map { $0.pokemonListState }.distinctUntilChanged()
    }
}
