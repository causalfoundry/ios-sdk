//
//  AppInfoObject.swift
//  
//
//  Created by khushbu on 22/09/23.
//

import Foundation


// MARK: - AppInfo
struct AppInfo: Codable {
    let id: String
    let minSDKVersion, targetSDKVersion: String
    let version: String
    let versionCode: String
    let versionName: String

    enum CodingKeys: String, CodingKey {
        case id
        case minSDKVersion = "min_sdk_version"
        case targetSDKVersion = "target_sdk_version"
        case version
        case versionCode = "version_code"
        case versionName = "version_name"
    }
}

// MARK: AppInfo convenience initializers and mutators

extension AppInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AppInfo.self, from: data)
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
        id: String? = nil,
        minSDKVersion: String? = nil,
        targetSDKVersion: String? = nil,
        version: String? = nil,
        versionCode: String? = nil,
        versionName: String? = nil
    ) -> AppInfo {
        return AppInfo(
            id: id ?? self.id,
            minSDKVersion: minSDKVersion ?? self.minSDKVersion,
            targetSDKVersion: targetSDKVersion ?? self.targetSDKVersion,
            version: version ?? self.version,
            versionCode: versionCode ?? self.versionCode,
            versionName: versionName ?? self.versionName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

