//
//  PregnancyDetailObject.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 30/4/24.
//

import Foundation

public struct PregnancyDetailObject: Codable {
    var pregnancyStatus: Bool
    var lastMenstrualPeriod: Int64?
    var highRisk: Bool?
    var gravida: Int?
    var parity: Int?
    var nFetus: Int?
    var neonatalOutcome: String?
    var maternalOutcome: String?

    enum CodingKeys: String, CodingKey {
        case pregnancyStatus = "pregnancy_status"
        case lastMenstrualPeriod = "last_menstrual_period"
        case highRisk = "high_risk"
        case gravida = "gravida"
        case parity = "parity"
        case nFetus = "n_fetus"
        case neonatalOutcome = "neonatal_outcome"
        case maternalOutcome = "maternal_outcome"
    }

    public init(pregnancyStatus: Bool, lastMenstrualPeriod: Int64? = nil, highRisk: Bool? = nil, gravida: Int? = nil, parity: Int? = nil, nFetus: Int? = nil, neonatalOutcome: String? = nil, maternalOutcome: String? = nil) {
        self.pregnancyStatus = pregnancyStatus
        self.lastMenstrualPeriod = lastMenstrualPeriod
        self.highRisk = highRisk
        self.gravida = gravida
        self.parity = parity
        self.nFetus = nFetus
        self.neonatalOutcome = neonatalOutcome
        self.maternalOutcome = maternalOutcome
    }

    // Encoding to JSON
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pregnancyStatus, forKey: .pregnancyStatus)
        try container.encodeIfPresent(lastMenstrualPeriod, forKey: .lastMenstrualPeriod)
        try container.encodeIfPresent(highRisk, forKey: .highRisk)
        try container.encodeIfPresent(gravida, forKey: .gravida)
        try container.encodeIfPresent(parity, forKey: .parity)
        try container.encodeIfPresent(nFetus, forKey: .nFetus)
        try container.encodeIfPresent(neonatalOutcome, forKey: .neonatalOutcome)
        try container.encodeIfPresent(maternalOutcome, forKey: .maternalOutcome)
    }

    // Decoding from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pregnancyStatus = try container.decode(Bool.self, forKey: .pregnancyStatus)
        lastMenstrualPeriod = try container.decodeIfPresent(Int64.self, forKey: .lastMenstrualPeriod)
        highRisk = try container.decodeIfPresent(Bool.self, forKey: .highRisk)
        gravida = try container.decodeIfPresent(Int.self, forKey: .gravida)
        parity = try container.decodeIfPresent(Int.self, forKey: .parity)
        nFetus = try container.decodeIfPresent(Int.self, forKey: .nFetus)
        neonatalOutcome = try container.decodeIfPresent(String.self, forKey: .neonatalOutcome)
        maternalOutcome = try container.decodeIfPresent(String.self, forKey: .maternalOutcome)
    }
}

