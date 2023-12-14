//
//  AppInfoObject.swift
//
//
//  Created by khushbu on 22/09/23.
//

import Foundation

struct AppInfo: Codable {
    let id: String
    let minSDKVersion, targetSDKVersion: Int
    let version: String
    let versionCode: Int
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
