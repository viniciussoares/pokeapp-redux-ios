import ReSwift

struct AppState: StateType {
    let pokemonsState: PokemonsState
}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        pokemonsState: pokemonsReducer(action: action, state: state?.pokemonsState)
    )
}

typealias AppStore = Store<AppState>
