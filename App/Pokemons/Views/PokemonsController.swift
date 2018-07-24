import UIKit

final class PokemonsController: LayoutController {
    override var layout: File { return R.file.pokemonsControllerXml }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    lazy var actions = PokemonsActions()
    lazy var selectors = PokemonsSelectors()

    override func layoutDidLoad() {
        bag << selectors.observe().subscribeNext {
            _ = $0
        }

        actions.getPokemons()
    }
}
