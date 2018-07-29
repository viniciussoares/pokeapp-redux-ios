import Foundation

public struct Attack: AutoEquatable, Decodable {
    public let name: String
    public let damage: Int

    public init(name: String, damage: Int) {
        self.name = name
        self.damage = damage
    }
}

public struct Attacks: AutoEquatable, Decodable {
    public let fast: [Attack]
    public let special: [Attack]

    public init(fast: [Attack] = [], special: [Attack] = []) {
        self.fast = fast
        self.special = special
    }
}
