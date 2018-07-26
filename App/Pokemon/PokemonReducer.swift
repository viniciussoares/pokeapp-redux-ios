import ReSwift

func pokemonReducer(action: Action, state: PokemonState?) -> PokemonState {
    var state = state ?? PokemonState()

    switch action {
    case _ as PokemonActionTypes.FetchRequest:
        state.isFetching = true
        state.error = nil

    case let action as PokemonActionTypes.FetchSuccess:
        state.byId[action.pokemon.id] = action.pokemon
        state.isFetching = false
        state.error = nil

    case let action as PokemonActionTypes.FetchError:
        state.isFetching = false
        state.error = action.error

    default: break
    }

    return state
}
