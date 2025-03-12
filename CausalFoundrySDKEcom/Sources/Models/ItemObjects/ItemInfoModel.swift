import Foundation

public struct ItemInfoModel: Codable {
    var itemId: String
    var type: String
    var batchId: String? = ""
    var surveyId: String? = ""
    var rewardId: String? = ""
    var isFeatured: Bool? = false
    var productionDate: Int64? = 0
    var expiryDate: Int64? = 0
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case type
        case batchId = "batch_id"
        case surveyId = "survey_id"
        case rewardId = "reward_id"
        case isFeatured = "is_featured"
        case productionDate = "production_date"
        case expiryDate = "expiry_date"
        case meta
    }

    public init(
        itemId: String,
        type: ItemType,
        batchId: String? = "",
        surveyId: String? = "",
        rewardId: String? = "",
        isFeatured: Bool? = false,
        productionDate: Int64? = 0,
        expiryDate: Int64? = 0,
        meta: Encodable? = nil
    ) {
        self.itemId = itemId
        self.type = type.rawValue
        self.batchId = batchId
        self.surveyId = surveyId
        self.rewardId = rewardId
        self.isFeatured = isFeatured
        self.productionDate = productionDate
        self.expiryDate = expiryDate
        self.meta = meta
    }

    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(batchId, forKey: .batchId)
        try container.encodeIfPresent(surveyId, forKey: .surveyId)
        try container.encodeIfPresent(rewardId, forKey: .rewardId)
        try container.encodeIfPresent(isFeatured, forKey: .isFeatured)
        try container.encodeIfPresent(productionDate, forKey: .productionDate)
        try container.encodeIfPresent(expiryDate, forKey: .expiryDate)
        if let metaData = meta {
            try container.encodeIfPresent(metaData, forKey: .meta)
        }
    }

    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try container.decode(String.self, forKey: .itemId)
        type = try container.decode(String.self, forKey: .type)
        batchId = try container.decodeIfPresent(String.self, forKey: .batchId)
        surveyId = try container.decodeIfPresent(String.self, forKey: .surveyId)
        rewardId = try container.decodeIfPresent(String.self, forKey: .rewardId)
        isFeatured = try container.decodeIfPresent(Bool.self, forKey: .isFeatured)
        productionDate = try container.decodeIfPresent(Int64.self, forKey: .productionDate)
        expiryDate = try container.decodeIfPresent(Int64.self, forKey: .expiryDate)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
