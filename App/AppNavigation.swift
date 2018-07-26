import UIKit

struct AppNavigation: AppNavigationType {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        switch navigation {
        case .pokemonDetail(let pokemon):
            return PokemonController.instance(id: pokemon.id)
        }
    }

    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
}
