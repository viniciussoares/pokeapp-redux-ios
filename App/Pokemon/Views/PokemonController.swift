import UIKit
import Data

final class PokemonController: LayoutController {
    private(set) var id = ""

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
        bag << selectors.observePokemon(id: id).subscribeNext {
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
