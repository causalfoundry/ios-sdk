//
//  APIConstants.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation

enum APIConstants {
    static let trackEvent = "\(CoreConstants.shared.apiUrl)ingest/log"
    static let ingestExceptionEvent = "\(CoreConstants.shared.apiUrl)ingest/sdk/crash"
    static let updateCatalog = "\(CoreConstants.shared.apiUrl)ingest/catalog/"
    static let fetchNudge = "\(CoreConstants.shared.apiUrl)nudge/sdk/"
}
