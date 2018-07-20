import ReSwift

private let initialState = PokemonsState(
    pokemons: [],
    isFetching: false,
    error: nil
)

func pokemonsReducer(action: Action, state: PokemonsState?) -> PokemonsState {
    var state = state ?? initialState

    switch action {
    case _ as PokemonsActionTypes.FetchRequest:
        state.isFetching = true
        state.error = nil

    case let action as PokemonsActionTypes.FetchSuccess:
        state.pokemons = action.pokemons
        state.isFetching = false
        state.error = nil

    case let action as PokemonsActionTypes.FetchError:
        state.isFetching = false
        state.error = action.error

    default: break
    }

    return state
}
