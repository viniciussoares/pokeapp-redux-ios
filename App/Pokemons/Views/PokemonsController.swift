import UIKit

final class PokemonsController: LayoutController {
    override var layout: File { return R.file.pokemonsControllerXml }

    lazy var actions = PokemonsActions()
    lazy var selectors = PokemonsSelectors()

    override func layoutDidLoad() {
        bag << selectors.observePokemons().subscribeNext {
            debugPrint("Pokemons: \($0)")
        }

        bag << selectors.observeIsFetching().subscribeNext {
            debugPrint("IsFetching: \($0)")
        }

        bag << selectors.observeError().subscribeNext {
            debugPrint("Error: \($0)")
        }

        actions.getPokemons()
    }
}
