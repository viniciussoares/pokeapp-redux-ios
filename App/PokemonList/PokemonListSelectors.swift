import ReSwift
import RxSwift
import Data

final class PokemonListSelectors: ContainerProvider {
    private lazy var store = container.resolve(AppStore.self)

    var state: PokemonListState {
        return store.state.pokemonListState
    }

    func observe() -> Observable<PokemonListState> {
        return store.asObservable().map { $0.pokemonListState }.distinctUntilChanged()
    }
}
