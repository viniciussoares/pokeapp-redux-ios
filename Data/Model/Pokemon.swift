import Foundation

public struct Pokemon: AutoEquatable, Decodable {
    public let id: String
    public let name: String
    public let image: String

    public init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}

func pokemonListFromJson(json: JSON) throws -> [Pokemon] {
    let pokemonsJson = json["pokemons"] as? [JSON] ?? []

    return try JSONDecoder().decode([Pokemon].self, fromJsonList: pokemonsJson)
}

func pokemonFromJson(json: JSON) throws -> Pokemon {
    let pokemonJson = json["pokemon"] as? JSON ?? [:]

    return try JSONDecoder().decode(Pokemon.self, fromJson: pokemonJson)
}
