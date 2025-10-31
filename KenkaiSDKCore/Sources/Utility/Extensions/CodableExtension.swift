//
//  CodableExtension.swift
//
//
//  Created by kenkai on 05.12.23.
//

// https://github.com/satyen95/mastering-codable/blob/main/mastering-codable/CodableExtensions.swift

import Foundation

struct JSONCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}

// MARK: - Decoding Extensions

extension KeyedDecodingContainer {
    func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
        let container = try nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.decode(type)
    }
    
    func decode(_: [[String: Any]].Type, forKey key: K) throws -> [[String: Any]] {
        var container = try nestedUnkeyedContainer(forKey: key)
        if let decodedData = try container.decode([Any].self) as? [[String: Any]] {
            return decodedData
        } else {
            return []
        }
    }
    
    func decodeIfPresent(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any]? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }
    
    func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
        var container = try nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }
    
    func decodeIfPresent(_ type: [Any].Type, forKey key: K) throws -> [Any]? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }
    
    func decode(_: [String: Any].Type) throws -> [String: Any] {
        var dictionary = [String: Any]()
        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode([Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            }
        }
        return dictionary
    }
}

extension UnkeyedDecodingContainer {
    mutating func decode(_: [Any].Type) throws -> [Any] {
        var array: [Any] = []
        while isAtEnd == false {
            // See if the current value in the JSON array is `null` first and prevent infite recursion with nested arrays.
            if try decodeNil() {
                continue
            } else if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode([String: Any].self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode([Any].self) {
                array.append(nestedArray)
            }
        }
        return array
    }
    
    mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}

// MARK: - Encoding Extensions

extension KeyedEncodingContainer {
    mutating func encodeIfPresent(_ value: [String: Any]?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let safeValue = value, !safeValue.isEmpty else {
            return
        }
        var container = nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        for item in safeValue {
            let typeID = CFGetTypeID(item.value as CFTypeRef)
            if let val = item.value as? Int, typeID == CFNumberGetTypeID() {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? String {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? Double, typeID == CFNumberGetTypeID() {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? Float, typeID == CFNumberGetTypeID() {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? Bool, typeID == CFBooleanGetTypeID()  {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [String: Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            }
        }
    }
    
    mutating func encodeIfPresent(_ value: [Any]?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let safeValue = value else {
            return
        }
        if let val = safeValue as? [Int] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [String] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [Double] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [Float] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [Bool] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = value as? [[String: Any]] {
            var container = nestedUnkeyedContainer(forKey: key)
            try container.encode(contentsOf: val)
        }
    }
}

extension UnkeyedEncodingContainer {
    mutating func encode(contentsOf sequence: [[String: Any]]) throws {
        for dict in sequence {
            try encodeIfPresent(dict)
        }
    }
    
    mutating func encodeIfPresent(_ value: [String: Any]) throws {
        var container = nestedContainer(keyedBy: JSONCodingKeys.self)
        for item in value {
            let typeID = CFGetTypeID(item.value as CFTypeRef)
            if let val = item.value as? Int, typeID == CFNumberGetTypeID() {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? String {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? Double, typeID == CFNumberGetTypeID() {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? Float, typeID == CFNumberGetTypeID() {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? Bool, typeID == CFBooleanGetTypeID()  {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [String: Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            }
        }
    }
}

// MARK: - Extra extensions for managing data easily

extension Decodable {
    init?(dictionary: [String: Any]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let decodedData = Utility.decode(Self.self, from: data) {
                self = decodedData
            } else {
                return nil
            }
        } catch _ {
            return nil
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else { return nil }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil }
        return jsonObject as? [String: Any]
    }
    
    var prettyJSON: String {
        dictionary?.prettyJSON ?? "{}"
    }
    
    func serializeToFlatMap() -> [String: Any] {
        guard let dict = dictionary else { return [:] }
        return flattenMap(dict)
    }
    
    func serializeToFlatMapString() -> [String: String] {
        guard let dict = dictionary else { return [:] }
        return flattenMapToString(dict)
    }
}

// Convert Any to snake_case key Dictionary<String, Any>
func flattenMap(_ input: [String: Any?]) -> [String: Any] {
    var result: [String: Any] = [:]
    
    for (key, value) in input {
        let newKey = key.toSnakeCase()
        
        switch value {
        case nil:
            continue
        case let str as String:
            if !str.isEmpty {
                result[newKey] = str
            }
        case let num as Int:
            result[newKey] = num
        case let num as Double:
            result[newKey] = num
        case let num as Float:
            result[newKey] = num
        case let bool as Bool:
            result[newKey] = bool
        case let list as [Any?]:
            let joined = list.compactMap { $0 }.map { "\($0)" }.joined(separator: ", ")
            if !joined.isEmpty {
                result[newKey] = joined
            }
        case let dict as [String: Any?]:
            let nested = flattenMap(dict)
            result.merge(nested) { _, new in new }
        default:
            if value == nil || value is NSNull {
                continue
            }
            if let dictValue = value as? [String: Any?] {
                let nested = flattenMap(dictValue)
                result.merge(nested) { _, new in new }
            } else if let arrayValue = value as? [Any?] {
                let joined = arrayValue.compactMap { $0 }.map { "\($0)" }.joined(separator: ", ")
                if !joined.isEmpty {
                    result[newKey] = joined
                }
            } else {
                result[newKey] = "\(value!)"
            }
        }
        
    }
    
    return result
}

// Flatten to [String: String]
func flattenMapToString(_ input: [String: Any?]) -> [String: String] {
    var result: [String: String] = [:]
    
    for (key, value) in input {
        let newKey = key.toSnakeCase()
        
        switch value {
        case nil:
            continue
        case let str as String:
            if !str.isEmpty {
                result[newKey] = str
            }
        case let num as Int:
            result[newKey] = "\(num)"
        case let num as Double:
            result[newKey] = "\(num)"
        case let num as Float:
            result[newKey] = "\(num)"
        case let bool as Bool:
            result[newKey] = "\(bool)"
        case let list as [Any?]:
            let joined = list.compactMap { $0 }.map { "\($0)" }.joined(separator: ", ")
            if !joined.isEmpty {
                result[newKey] = joined
            }
        case let dict as [String: Any?]:
            let nested = flattenMapToString(dict)
            result.merge(nested) { _, new in new }
        default:
            if value == nil || value is NSNull {
                continue
            }
            if let dictValue = value as? [String: Any?] {
                let nested = flattenMapToString(dictValue)
                result.merge(nested) { _, new in new }
            } else if let arrayValue = value as? [Any?] {
                let joined = arrayValue.compactMap { $0 }.map { "\($0)" }.joined(separator: ", ")
                if !joined.isEmpty {
                    result[newKey] = joined
                }
            } else {
                let str = "\(value!)"
                if !str.isEmpty {
                    result[newKey] = str
                }
            }
        }
        
    }
    
    return result
}


extension Dictionary {
    var prettyJSON: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            print("json serialization error: \(error)")
            return "{}"
        }
    }
}

private extension Dictionary where Key == String, Value == Any {
    var isStrictlyPrimitive: Bool {
        return self.allSatisfy { (_, value) in
            isStrictlyPrimitiveValue(value)
        }
    }
}

private func isStrictlyPrimitiveValue(_ value: Any) -> Bool {
    switch value {
    case is String, is Int, is Double, is Bool, is NSNull:
        return true
    case let array as [Any]:
        return array.allSatisfy { isStrictlyPrimitiveValue($0) }
    case let dict as [String: Any]:
        return dict.isStrictlyPrimitive
    default:
        return false
    }
}



enum Utility {
    static func decode<T>(_: T.Type, from data: Data) -> T? where T: Decodable {
        var decodedData: T?
        do {
            decodedData = try JSONDecoder.new.decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return decodedData
    }
}
