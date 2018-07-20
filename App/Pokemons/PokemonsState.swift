import ReSwift
import Services

struct PokemonsState: StateType {
    var pokemons: [Pokemon]
    var isFetching: Bool
    var error: Error?
}
