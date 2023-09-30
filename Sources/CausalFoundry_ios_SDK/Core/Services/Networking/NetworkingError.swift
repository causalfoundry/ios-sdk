//
//  File.swift
//  
//
//  Created by khushbu on 25/09/23.
//

import Foundation


import Foundation

enum NetworkingError: LocalizedError {
    
    case badJSON
    
    public var errorDescription: String? {
        switch self {
        case .badJSON:
            return NSLocalizedString("The data from the server came back in a way we couldn't use", comment: "")
        }
    }
}
