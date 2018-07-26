import ReSwift
import RxSwift
import Data

protocol PokemonActions: AutoMockable {
    func getPokemon(id: String)
}

final class DefaultPokemonActions: PokemonActions {
    private let bag = DisposeBag()
    private let selectors = PokemonSelectors()

    private lazy var store = UIApplication.container.resolve(AppStore.self)!
    private lazy var repository = UIApplication.container.resolve(PokemonRepository.self)!

    func getPokemon(id: String) {
        if selectors.isFetching || selectors.hasCache(for: id) { return }

        store.dispatch(PokemonActionTypes.FetchRequest())

        bag << repository.getPokemon(id: id).subscribe(onNext: {
            self.store.dispatch(PokemonActionTypes.FetchSuccess(pokemon: $0))
        }, onError: {
            self.store.dispatch(PokemonActionTypes.FetchError(error: $0))
        })
    }
}
