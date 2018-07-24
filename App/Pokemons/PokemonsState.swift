import ReSwift
import Data

struct PokemonsState: StateType, AutoEquatable {
    var pokemons: [Pokemon]
    var isFetching: Bool
    var error: Error?
}
