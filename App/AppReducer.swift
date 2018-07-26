import ReSwift

struct AppState: StateType {
    var pokemonListState = PokemonListState()
    var pokemonState = PokemonState()
}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        pokemonListState: pokemonListReducer(action: action, state: state?.pokemonListState),
        pokemonState: pokemonReducer(action: action, state: state?.pokemonState)
    )
}

typealias AppStore = Store<AppState>
