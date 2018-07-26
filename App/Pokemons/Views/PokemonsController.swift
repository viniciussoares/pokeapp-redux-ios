import UIKit
import Data

final class PokemonsController: LayoutController {
    @objc var collectionView: UICollectionView!
    @objc var activityIndicatorView: ActivityIndicatorView!
    @objc var errorView: ErrorView!

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
            self.errorView.error = $0.error
        }

        bag << errorView.rx.retry.subscribeNext {
            self.actions.getPokemons()
        }

        actions.getPokemons()
    }
}
