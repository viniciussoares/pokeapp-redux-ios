import RxSwift

public protocol PokemonRepository: AutoMockable {
    func getPokemons() -> Observable<[Pokemon]>
    func getPokemon(id: String) -> Observable<Pokemon>
}

public final class DefaultPokemonRepository: PokemonRepository {
    private let api: Api

    init(api: Api) {
        self.api = api
    }

    public init() {
        self.api = DefaultApi.default
    }

    public func getPokemons() -> Observable<[Pokemon]> {
        let query = GetPokemonsQuery()
        return api.fetch(query: query).map { try pokemonListFromJson(json: $0) }
    }

    public func getPokemon(id: String) -> Observable<Pokemon> {
        return .empty()
    }
}
