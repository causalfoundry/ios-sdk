//
//  DeviceInfoObject.swift
//
//
//  Created by khushbu on 22/09/23.
//

import Foundation

struct DInfo: Codable {
    let brand, id, model, os: String
    let osVer: String

    enum CodingKeys: String, CodingKey {
        case brand, id, model, os
        case osVer = "os_ver"
    }
}
