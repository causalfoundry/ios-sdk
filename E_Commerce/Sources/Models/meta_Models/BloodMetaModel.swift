//
//  BloodMetaModel.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

public struct BloodMetaModel: Codable {
    var cross_matching: Bool
    var temperature_strips: Bool
    var extra_tests: Bool
    var reason: String

    enum CodingKeys: String, CodingKey {
        case cross_matching
        case temperature_strips
        case extra_tests
        case reason
    }

   public init(cross_matching: Bool = false, temperature_strips: Bool = false, extra_tests: Bool = false, reason: String = "") {
        self.cross_matching = cross_matching
        self.temperature_strips = temperature_strips
        self.extra_tests = extra_tests
        self.reason = reason
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cross_matching = try container.decode(Bool.self, forKey: .cross_matching)
        temperature_strips = try container.decode(Bool.self, forKey: .temperature_strips)
        extra_tests = try container.decode(Bool.self, forKey: .extra_tests)
        reason = try container.decode(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cross_matching, forKey: .cross_matching)
        try container.encode(temperature_strips, forKey: .temperature_strips)
        try container.encode(extra_tests, forKey: .extra_tests)
        try container.encode(reason, forKey: .reason)
    }
}

