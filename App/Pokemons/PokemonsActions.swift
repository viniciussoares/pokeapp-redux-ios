import ReSwift
import RxSwift
import Services

final class PokemonsActions {
    func getPokemons() -> Disposable {
        store.dispatch(PokemonsActionTypes.FetchRequest())

        let pikachu = Pokemon(id: "1", name: "Pikachu")

        return Observable
            .just([pikachu])
            .delay(4, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                store.dispatch(PokemonsActionTypes.FetchSuccess(pokemons: $0))
            }, onError: {
                store.dispatch(PokemonsActionTypes.FetchError(error: $0))
            })
    }
}
