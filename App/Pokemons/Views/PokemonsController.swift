import UIKit

final class PokemonsController: LayoutController {
    override var layout: File { return R.file.pokemonsControllerXml }

    override func layoutDidLoad() {
        observeStore()

        bag << PokemonsActions().getPokemons()
    }

    private func observeStore() {
        bag << store.observePure { $0.pokemonsState.pokemons }.subscribeNext {
            debugPrint("pokemons: \($0)")
        }

        bag << store.observe { $0.pokemonsState.isFetching }.subscribeNext {
            debugPrint("isFetching: \($0)")
        }

        bag << store.observe { $0.pokemonsState.error }.subscribeNext {
            debugPrint("Error: \($0)")
        }
    }
}
