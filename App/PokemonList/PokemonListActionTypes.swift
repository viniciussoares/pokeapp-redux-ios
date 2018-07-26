import ReSwift
import Data

enum PokemonListActionTypes {
    struct FetchRequest: Action {}

    struct FetchSuccess: Action {
        let pokemons: [Pokemon]
    }

    struct FetchError: Action {
        let error: Error
    }
}
