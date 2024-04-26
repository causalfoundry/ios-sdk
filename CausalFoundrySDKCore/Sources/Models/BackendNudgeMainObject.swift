//
//  BackendNudgeMainObject.swift
//
//
//  Created by Causal Foundry on 29.11.23.
//

import Foundation

// MARK: - BackendNudgeMainObject

public struct BackendNudgeMainObject: Codable, Hashable {
    
    let ref: String
    let time: String
    let expire_at: String?
    let nd: Nd
    let extra: Extra?
    
    var isExpired: Bool {
        guard expire_at != "0001-01-01T00:00:00Z" else { return false }
        guard let date = ISO8601DateFormatter().date(from: expire_at ?? "") else { return false }
        return Date().timeIntervalSince(date) > 0
    }

    // MARK: - Extra

    struct Extra: Codable, Hashable {
        let traits: [String: TraitsCodableValue]?
        let itemPair: ItemPair?

        enum CodingKeys: String, CodingKey {
            case traits
            case itemPair = "item_pair"
        }
    }

    // MARK: - ItemPair

    struct ItemPair: Codable, Hashable {
        let ids, names: [String]?
    }

    // MARK: - Nd

    struct Nd: Codable, Hashable {
        let type: String?
        let message: Message
        let renderMethod: RenderMethod?
        let cta: String?

        enum CodingKeys: String, CodingKey {
            case type, message
            case renderMethod = "render_method"
            case cta
        }
    }
    
    // MARK: - Nd

    enum RenderMethod: String, Codable, Hashable {
        case pushNotification = "push_notification"
        case inAppMessage = "in_app_message"
        case inAppComponent = "in_app_component"
    }

    // MARK: - Message

    struct Message: Codable, Hashable {
        let title: String
        let tmplCFG: TmplCFG?
        let body: String
        let tags: [String]?

        enum CodingKeys: String, CodingKey {
            case title
            case tmplCFG = "tmpl_cfg"
            case body, tags
        }
    }

    // MARK: - TmplCFG

    struct TmplCFG: Codable, Hashable {
        let tmplType: String?
        let itemPairCFG: ItemPairCFG?
        let traits: [String]?

        enum CodingKeys: String, CodingKey {
            case tmplType = "tmpl_type"
            case itemPairCFG = "item_pair_cfg"
            case traits
        }
    }

    // MARK: - ItemPairCFG

    struct ItemPairCFG: Codable, Hashable {
        let itemType, pairRankType: String?

        enum CodingKeys: String, CodingKey {
            case itemType = "item_type"
            case pairRankType = "pair_rank_type"
        }
    }
}

enum TraitsCodableValue: Codable, Hashable {
    case string(String)
    case int(Int)
    // Add other types you want to support

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else {
            // Handle other types or throw an error for unsupported types
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported type")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        // Add encoding logic for other supported types
        }
    }
}
