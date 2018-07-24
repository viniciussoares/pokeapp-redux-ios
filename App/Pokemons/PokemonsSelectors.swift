import ReSwift
import RxSwift
import Data

final class PokemonsSelectors: ContainerProvider {
    private lazy var store = container.resolve(AppStore.self)

    var state: PokemonsState {
        return store.state.pokemonsState
    }

    func observe() -> Observable<PokemonsState> {
        return store.asObservable().map { $0.pokemonsState }.distinctUntilChanged()
    }
}
