import ReSwift

struct AppState: StateType {
    var pokemonListState = PokemonListState()
}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        pokemonListState: pokemonListReducer(action: action, state: state?.pokemonListState)
    )
}

typealias AppStore = Store<AppState>
