//
//  BloodMetaModel.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

public struct BloodMetaModel: Codable {
    var crossMatching: Bool
    var temperatureStrips: Bool
    var extraTests: Bool
    var reason: String

    enum CodingKeys: String, CodingKey {
        case crossMatching = "cross_matching"
        case temperatureStrips = "temperature_strips"
        case extraTests = "extra_tests"
        case reason
    }

    public init(crossMatching: Bool = false, temperatureStrips: Bool = false, extraTests: Bool = false, reason: String = "") {
        self.crossMatching = crossMatching
        self.temperatureStrips = temperatureStrips
        self.extraTests = extraTests
        self.reason = reason
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        crossMatching = try container.decode(Bool.self, forKey: .crossMatching)
        temperatureStrips = try container.decode(Bool.self, forKey: .temperatureStrips)
        extraTests = try container.decode(Bool.self, forKey: .extraTests)
        reason = try container.decode(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(crossMatching, forKey: .crossMatching)
        try container.encode(temperatureStrips, forKey: .temperatureStrips)
        try container.encode(extraTests, forKey: .extraTests)
        try container.encode(reason, forKey: .reason)
    }
}
