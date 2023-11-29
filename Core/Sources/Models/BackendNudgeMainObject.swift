//
//  BackendNudgeMainObject.swift
//  
//
//  Created by Causal Foundry on 29.11.23.
//

import Foundation

// MARK: - BackendNudgeMainObject
struct BackendNudgeMainObject: Codable {
    let ref: String
    let time: Date
    let nd: Nd
    let extra: Extra?
    
    // MARK: - Extra
    struct Extra: Codable {
        let traits: Traits?
        let itemPair: ItemPair?

        enum CodingKeys: String, CodingKey {
            case traits
            case itemPair = "item_pair"
        }
    }

    // MARK: - ItemPair
    struct ItemPair: Codable {
        let ids, names: [String]?
    }

    // MARK: - Traits
    struct Traits: Codable {
        let dataCTUserCountry: String?

        enum CodingKeys: String, CodingKey {
            case dataCTUserCountry = "data.ct_user.country"
        }
    }

    // MARK: - Nd
    struct Nd: Codable {
        let type: String?
        let message: Message?
        let renderMethod, cta: String?

        enum CodingKeys: String, CodingKey {
            case type, message
            case renderMethod = "render_method"
            case cta
        }
    }

    // MARK: - Message
    struct Message: Codable {
        let title: String?
        let tmplCFG: TmplCFG?
        let body: String?
        let tags: [String]?

        enum CodingKeys: String, CodingKey {
            case title
            case tmplCFG = "tmpl_cfg"
            case body, tags
        }
    }

    // MARK: - TmplCFG
    struct TmplCFG: Codable {
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
    struct ItemPairCFG: Codable {
        let itemType, pairRankType: String?

        enum CodingKeys: String, CodingKey {
            case itemType = "item_type"
            case pairRankType = "pair_rank_type"
        }
    }

}

