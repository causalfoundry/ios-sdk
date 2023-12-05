//
//  IdentityObject.swift
//
//
//  Created by khushbu on 05/10/23.
//

import Foundation

struct IdentifyObject: Codable {
    struct Blocked: Codable {
        let reason: String
        let remarks: String?
    }

    let action: String?
    let blocked: Blocked?
}
