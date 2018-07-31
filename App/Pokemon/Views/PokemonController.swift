import UIKit
import Data
import MaterialComponents

final class PokemonController: LayoutController {
    private(set) var id = ""

    @objc var navigationBar: NavigationBar!
    @objc var scrollView: UIScrollView!
    @objc var fastAttacksTableView: UITableView!
    @objc var specialAttacksTableView: UITableView!
    @objc var evolutionsCollectionView: UICollectionView!
    @objc var activityIndicatorView: ActivityIndicatorView!
    @objc var errorView: ErrorView!

    lazy var actions: PokemonActions = DefaultPokemonActions()
    lazy var selectors = PokemonSelectors()

    let fastAttacksAdapter = AttackAdapter()
    let specialAttacksAdapter = AttackAdapter()
    let evolutionsAdapter = EvolutionsAdapter()

    override var layout: File {
        return R.file.pokemonControllerXml
    }

    override var initialState: [String: Any] {
        return ["pokemon": Pokemon(id: "", name: "", image: "")]
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
        navigationItem.leftBarButtonItem = BackBarButtonItem(parent: self)
        navigationBar.observe(navigationItem)

        fastAttacksAdapter.tableView = fastAttacksTableView
        specialAttacksAdapter.tableView = specialAttacksTableView
        evolutionsAdapter.collectionView = evolutionsCollectionView

        bag << selectors.observePokemon(id: id).subscribeNext {
            self.setState(["pokemon": $0])
            self.navigationItem.title = $0.name
            self.fastAttacksAdapter.attacks = $0.attacks.fast
            self.specialAttacksAdapter.attacks = $0.attacks.special
            self.evolutionsAdapter.pokemons = $0.evolutions
            self.layoutNode?.update()
        }

        bag << selectors.observeIsFetching().subscribeNext {
            self.scrollView.isHidden = $0
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
