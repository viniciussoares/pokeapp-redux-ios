import ReSwift
import Services

enum PokemonsActionTypes {
    struct FetchRequest: Action {}

    struct FetchSuccess: Action {
        let pokemons: [Pokemon]
    }

    struct FetchError: Action {
        let error: Error
    }
}
