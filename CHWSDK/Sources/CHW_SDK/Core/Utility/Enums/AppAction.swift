//
//  File.swift
//
//
//  Created by khushbu on 17/09/23.
//

import Foundation


public enum AppAction {
    
    case open,
         close,
         background,
         resume
    
    var rawValue: String {
        switch self {
        case .open: return "open"
        case .close: return "close"
        case .background: return "background"
        case .resume: return "resume"
        }
    }
    
    func compareMatchingValue(value:String) -> String {
        switch self {
        case .background:
            return self.rawValue
        case .close:
            return self.rawValue
        case .open:
            return self.rawValue
        case .resume:
            return self.rawValue
        }
    }
    
}
