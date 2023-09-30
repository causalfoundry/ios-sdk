//
//  DeviceInfoObject.swift
//  
//
//  Created by khushbu on 22/09/23.
//

import Foundation

// MARK: DInfo convenience initializers and mutators
// MARK: - DInfo
struct DInfo: Codable {
    let brand, id, model, os: String
    let osVer: String

    enum CodingKeys: String, CodingKey {
        case brand, id, model, os
        case osVer = "os_ver"
    }
}

extension DInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DInfo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        brand: String? = nil,
        id: String? = nil,
        model: String? = nil,
        os: String? = nil,
        osVer: String? = nil
    ) -> DInfo {
        return DInfo(
            brand: brand ?? self.brand,
            id: id ?? self.id,
            model: model ?? self.model,
            os: os ?? self.os,
            osVer: osVer ?? self.osVer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
