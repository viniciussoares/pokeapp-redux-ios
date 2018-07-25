import UIKit
import Data

final class PokemonsController: LayoutController {
    @objc var collectionView: UICollectionView!

    private let adapter = PokemonsAdapter()

    lazy var actions = PokemonsActions()
    lazy var selectors = PokemonsSelectors()

    override var layout: File {
        return R.file.pokemonsControllerXml
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func layoutDidLoad() {
        adapter.collectionView = collectionView

        bag << selectors.observe().subscribeNext {
            self.adapter.pokemons = $0.pokemons
        }

        actions.getPokemons()
    }
}
