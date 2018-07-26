import ReSwift
import Data

struct PokemonsState: StateType, AutoEquatable {
    var pokemons: [Pokemon] = []
    var isFetching: Bool = false
    var error: Error?
}
