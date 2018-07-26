import ReSwift
import Data

struct PokemonState: StateType, AutoEquatable {
    var byId: [String: Pokemon] = [:]
    var isFetching: Bool = false
    var error: Error?
}
