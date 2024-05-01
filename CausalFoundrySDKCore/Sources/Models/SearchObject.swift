//
//  SearchObject.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

struct SearchObject: Codable {
    var searchId: String?
    var query: String?
    var searchModule: String?
    var resultsList: Any?
    var filter: Any?
    var page: Int
    var meta: Any?

    init(searchId: String,
         query: String,
         searchModule: String,
         resultsList: Any? = nil,
         filter: Any? = nil,
         page: Int = 1,
         meta: Any? = nil)
    {
        self.searchId = searchId
        self.query = query
        self.searchModule = searchModule
        self.resultsList = resultsList
        self.filter = filter
        self.page = page
        self.meta = meta
    }

    private enum CodingKeys: String, CodingKey {
        case searchId = "id"
        case query
        case searchModule = "module"
        case resultsList = "results_list"
        case filter
        case page
        case meta
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        searchId = try values.decodeIfPresent(String.self, forKey: .searchId)!
        searchModule = try values.decodeIfPresent(String.self, forKey: .searchModule)!
        query = try values.decodeIfPresent(String.self, forKey: .query)!
        page = try values.decodeIfPresent(Int.self, forKey: .page)!

        if let decodeMetaInt = try values.decodeIfPresent(Int.self, forKey: .meta) {
            meta = decodeMetaInt
        } else if let decodeMetaString = try values.decodeIfPresent(String.self, forKey: .meta) {
            meta = decodeMetaString
        } else {
            meta = nil
        }

        if let decodeMetaInt = try values.decodeIfPresent(String.self, forKey: .resultsList) {
            resultsList = decodeMetaInt
        } else {
            resultsList = nil
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
        try baseContainer.encode(searchId, forKey: .searchId)

        try baseContainer.encode(query, forKey: .query)
        try baseContainer.encode(searchModule, forKey: .searchModule)
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

        let dataEncoderResult = baseContainer.superEncoder(forKey: .resultsList)

        if let resultTypeDictionary = resultsList as? [SearchItemModel] {
            try (resultTypeDictionary).encode(to: dataEncoderResult)
        } else if let metaAsString = resultsList as? String {
            try (metaAsString).encode(to: dataEncoderResult)
        } else if let metaAsDouble = resultsList as? Double {
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
