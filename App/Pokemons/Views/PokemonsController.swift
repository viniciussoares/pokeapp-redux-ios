import UIKit

final class PokemonsController: LayoutController {
    override var layout: File { return R.file.pokemonsControllerXml }

    let actions = PokemonsActions()

    override func layoutDidLoad() {
        bag << actions.getPokemons()
    }
}
