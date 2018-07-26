import ReSwift
import Data

enum PokemonActionTypes {
    struct FetchRequest: Action {}

    struct FetchSuccess: Action {
        let pokemon: Pokemon
    }

    struct FetchError: Action {
        let error: Error
    }
}
