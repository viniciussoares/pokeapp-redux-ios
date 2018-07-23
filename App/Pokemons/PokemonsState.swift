import ReSwift
import Data

struct PokemonsState: StateType {
    var pokemons: [Pokemon]
    var isFetching: Bool
    var error: Error?
}
