import ReSwift

func pokemonListReducer(action: Action, state: PokemonListState?) -> PokemonListState {
    var state = state ?? PokemonListState()

    switch action {
    case _ as PokemonListActionTypes.FetchRequest:
        state.isFetching = true
        state.error = nil

    case let action as PokemonListActionTypes.FetchSuccess:
        state.pokemons = action.pokemons
        state.isFetching = false
        state.error = nil

    case let action as PokemonListActionTypes.FetchError:
        state.isFetching = false
        state.error = action.error

    default: break
    }

    return state
}
