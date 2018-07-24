import ReSwift
import RxSwift
import Data

class PokemonsActions: ContainerProvider {
    private let bag = DisposeBag()
    private let selectors = PokemonsSelectors()

    private lazy var store = container.resolve(AppStore.self)
    private lazy var repository = container.resolve(PokemonRepository.self)

    func getPokemons() {
        if selectors.state.isFetching { return }

        store.dispatch(PokemonsActionTypes.FetchRequest())

        bag << repository.getPokemons().subscribe(onNext: {
            self.store.dispatch(PokemonsActionTypes.FetchSuccess(pokemons: $0))
        }, onError: {
            self.store.dispatch(PokemonsActionTypes.FetchError(error: $0))
        })
    }
}

final class PokemonsActionsMock: PokemonsActions {
    override func getPokemons() {}
}
