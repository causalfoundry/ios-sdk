//
//  APIConstants.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation


struct APIConstants {
    static let  trackEvent = "\(CoreConstants.shared.devUrl)ingest/log"
    static let  ingestExceptionEvent = "\(CoreConstants.shared.devUrl)ingest/sdk/crash"
    static let  updateCatalog = "\(CoreConstants.shared.devUrl)ingest/catalog/{subject}"
}

