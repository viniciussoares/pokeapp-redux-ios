import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, fromJson json: JSON) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: json)
        return try decode(type, from: data)
    }

    func decode<T>(_ type: T.Type, fromJsonList jsonList: [JSON]) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: jsonList)
        return try decode(type, from: data)
    }
}
