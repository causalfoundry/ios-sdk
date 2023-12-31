//
//  CoreEventType.swift
//
//
//  Created by khushbu on 17/09/23.
//

import Foundation

enum CoreEventType: CaseIterable {
    case identify,
         page,
         app,
         search,
         media,
         nudge_response,
         rate,
         track

    var rawValue: String {
        switch self {
        case .identify: return "identity"
        case .page: return "page"
        case .app: return "app"
        case .search: return "search"
        case .media: return "media"
        case .nudge_response: return "nudge_response"
        case .rate: return "rate"
        case .track: return "track"
        }
    }
}
