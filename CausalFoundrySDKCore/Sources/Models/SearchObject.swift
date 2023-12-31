//
//  SearchObject.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

struct SearchObject: Codable {
    var search_id: String?
    var query: String?
    var search_module: String?
    var results_list: Any?
    var filter: Any?
    var page: Int
    var meta: Any?

    init(search_id: String,
         query: String,
         search_module: String,
         results_list: Any? = nil,
         filter: Any? = nil,
         page: Int = 1,
         meta: Any? = nil)
    {
        self.search_id = search_id
        self.query = query
        self.search_module = search_module
        self.results_list = results_list
        self.filter = filter
        self.page = page
        self.meta = meta
    }

    private enum CodingKeys: String, CodingKey {
        case search_id = "id"
        case query
        case search_module = "module"
        case results_list
        case filter
        case page
        case meta
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)!
        search_module = try values.decodeIfPresent(String.self, forKey: .search_module)!
        query = try values.decodeIfPresent(String.self, forKey: .query)!
        page = try values.decodeIfPresent(Int.self, forKey: .page)!

        if let decodeMetaInt = try values.decodeIfPresent(Int.self, forKey: .meta) {
            meta = decodeMetaInt
        } else if let decodeMetaString = try values.decodeIfPresent(String.self, forKey: .meta) {
            meta = decodeMetaString
        } else {
            meta = nil
        }

        if let decodeMetaInt = try values.decodeIfPresent(String.self, forKey: .results_list) {
            results_list = decodeMetaInt
        } else {
            results_list = nil
        }

        if let decodeMetaInt = try values.decodeIfPresent([String: String].self, forKey: .filter) {
            filter = decodeMetaInt
        } else if let decodeMetaString = try values.decodeIfPresent(String.self, forKey: .filter) {
            filter = decodeMetaString
        } else {
            filter = nil
        }
    }

    // MARK: Encodable

    func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(search_id, forKey: .search_id)

        try baseContainer.encode(query, forKey: .query)
        try baseContainer.encode(search_module, forKey: .search_module)
        try baseContainer.encode(page, forKey: .page)

        let dataEncoder = baseContainer.superEncoder(forKey: .meta)

        // Use the Encoder directly:
        if let metaAsInt = meta as? Int {
            try (metaAsInt).encode(to: dataEncoder)
        } else if let metaAsString = meta as? String {
            try (metaAsString).encode(to: dataEncoder)
        } else if let metaAsDouble = meta as? Double {
            try (metaAsDouble).encode(to: dataEncoder)
        }

        let dataEncoderResult = baseContainer.superEncoder(forKey: .results_list)

        if let resultTypeDictionary = results_list as? [SearchItemModel] {
            try (resultTypeDictionary).encode(to: dataEncoderResult)
        } else if let metaAsString = results_list as? String {
            try (metaAsString).encode(to: dataEncoderResult)
        } else if let metaAsDouble = results_list as? Double {
            try (metaAsDouble).encode(to: dataEncoderResult)
        }

        let dataEncoderFilter = baseContainer.superEncoder(forKey: .filter)
        if let resultTypeDictionary = filter as? [String: String] {
            try (resultTypeDictionary).encode(to: dataEncoderFilter)
        }
    }
}

func serializeToJSON(data: Any) -> Data? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
        return jsonData
    } catch {
        print("Error serializing to JSON: \(error.localizedDescription)")
        return nil
    }
}
