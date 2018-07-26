import ReSwift
import Data

struct PokemonListState: StateType, AutoEquatable {
    var pokemons: [Pokemon] = []
    var isFetching: Bool = false
    var error: Error?
}
