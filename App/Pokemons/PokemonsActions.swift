import ReSwift
import RxSwift
import Data

class PokemonsActions: ContainerProvider {
    private let bag = DisposeBag()
    private let selectors = PokemonsSelectors()

    private lazy var store = container.resolve(AppStore.self)

    func getPokemons() {
        if selectors.isFetching { return }

        store.dispatch(PokemonsActionTypes.FetchRequest())

        let pikachu = Pokemon(id: "1", name: "Pikachu")

        bag << Observable
            .just([pikachu])
            .delay(4, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.store.dispatch(PokemonsActionTypes.FetchSuccess(pokemons: $0))
            }, onError: {
                self.store.dispatch(PokemonsActionTypes.FetchError(error: $0))
            })
    }
}

final class PokemonsActionsMock: PokemonsActions {
    override func getPokemons() {}
}
