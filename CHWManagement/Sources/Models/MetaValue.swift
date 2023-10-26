//
//  File.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import Foundation


public enum MetaValue: Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case array([MetaValue])
    case dictionary([String: MetaValue])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            self = .string(string)
            return
        }
        if let int = try? container.decode(Int.self) {
            self = .int(int)
            return
        }
        if let double = try? container.decode(Double.self) {
            self = .double(double)
            return
        }
        if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
            return
        }
        if let array = try? container.decode([MetaValue].self) {
            self = .array(array)
            return
        }
        if let dictionary = try? container.decode([String: MetaValue].self) {
            self = .dictionary(dictionary)
            return
        }
        
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid meta value")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .dictionary(let value):
            try container.encode(value)
        }
    }
}
