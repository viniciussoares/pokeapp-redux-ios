import UIKit
import Data

final class PokemonController: LayoutController {
    private(set) var id = ""

    @objc var navigationBar: NavigationBar!
    @objc var activityIndicatorView: ActivityIndicatorView!
    @objc var errorView: ErrorView!

    lazy var actions: PokemonActions = DefaultPokemonActions()
    lazy var selectors = PokemonSelectors()

    override var layout: File {
        return R.file.pokemonControllerXml
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    static func instance(id: String) -> PokemonController {
        let controller = PokemonController()
        controller.id = id
        return controller
    }

    override func layoutDidLoad() {
        navigationItem.title = "Pokemón"
        navigationItem.hidesBackButton = false
        navigationBar.observe(navigationItem)

        bag << selectors.observePokemon(id: id).subscribeNext {
            self.navigationItem.title = $0.name
            print($0)
        }

        bag << selectors.observeIsFetching().subscribeNext {
            self.activityIndicatorView.isLoading = $0
        }

        bag << selectors.observeError().subscribeNext {
            self.errorView.error = $0
        }

        bag << errorView.rx.retry.subscribeNext {
            self.actions.getPokemon(id: self.id)
        }

        actions.getPokemon(id: id)
    }
}
