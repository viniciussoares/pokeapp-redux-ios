import Foundation

public struct Pokemon: AutoEquatable, Decodable {
    public var id: String
    public var name: String
    public var image: String
    public var type: String = ""
    public var resistant: String = ""
    public var weaknesses: String = ""
    public var attacks: Attacks = Attacks()
    public var evolutions: [Pokemon] = []

    enum Keys: String, CodingKey {
        case id
        case name
        case image
        case types
        case resistant
        case weaknesses
        case attacks
        case evolutions
    }

    public init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)

        let typeList = try container.decodeIfPresent([String].self, forKey: .types) ?? []
        self.type = typeList.isEmpty ? "-" : typeList.joined(separator: ", ")

        let resistantList = try container.decodeIfPresent([String].self, forKey: .resistant) ?? []
        self.resistant = resistantList.isEmpty ? "-" : resistantList.joined(separator: ", ")

        let weaknessesList = try container.decodeIfPresent([String].self, forKey: .weaknesses) ?? []
        self.weaknesses = weaknessesList.isEmpty ? "-" : weaknessesList.joined(separator: ", ")

        self.attacks = try container.decodeIfPresent(Attacks.self, forKey: .attacks) ?? Attacks()

        self.evolutions = try container.decodeIfPresent([Pokemon].self, forKey: .evolutions) ?? []
        self.evolutions.insert(contentsOf: [Pokemon(id: id, name: name, image: image)], at: 0)
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
