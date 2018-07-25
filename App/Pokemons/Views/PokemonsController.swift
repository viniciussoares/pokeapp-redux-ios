import UIKit
import Data

final class PokemonsController: LayoutController {
    @objc var collectionView: UICollectionView!
    @objc var activityIndicatorView: ActivityIndicatorView!

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
            self.activityIndicatorView.isLoading = $0.isFetching
        }

        actions.getPokemons()
    }
}
