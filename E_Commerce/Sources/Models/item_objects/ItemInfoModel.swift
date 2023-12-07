import Foundation

public struct ItemInfoModel: Codable {
    var id: String
    var type: String
    var batchId: String? = ""
    var surveyId: String? = ""
    var rewardId: String? = ""
    var isFeatured: Bool? = false
    var productionDate: Int64? = 0
    var expiryDate: Int64? = 0

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case batchId = "batch_id"
        case surveyId = "survey_id"
        case rewardId = "reward_id"
        case isFeatured = "is_featured"
        case productionDate = "production_date"
        case expiryDate = "expiry_date"
    }

    public init(
        id: String,
        type: String,
        batchId: String? = "",
        surveyId: String? = "",
        rewardId: String? = "",
        isFeatured: Bool? = false,
        productionDate: Int64? = 0,
        expiryDate: Int64? = 0
    ) {
        self.id = id
        self.type = type
        self.batchId = batchId
        self.surveyId = surveyId
        self.rewardId = rewardId
        self.isFeatured = isFeatured
        self.productionDate = productionDate
        self.expiryDate = expiryDate
    }

    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(batchId, forKey: .batchId)
        try container.encode(surveyId, forKey: .surveyId)
        try container.encode(rewardId, forKey: .rewardId)
        try container.encode(isFeatured, forKey: .isFeatured)
        try container.encode(productionDate, forKey: .productionDate)
        try container.encode(expiryDate, forKey: .expiryDate)
    }

    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        batchId = try container.decode(String.self, forKey: .batchId)
        surveyId = try container.decode(String.self, forKey: .surveyId)
        rewardId = try container.decode(String.self, forKey: .rewardId)
        isFeatured = try container.decode(Bool.self, forKey: .isFeatured)
        productionDate = try container.decode(Int64.self, forKey: .productionDate)
        expiryDate = try container.decode(Int64.self, forKey: .expiryDate)
    }
}
