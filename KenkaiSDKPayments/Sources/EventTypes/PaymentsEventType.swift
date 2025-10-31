//
//  PaymentsEventType.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

public enum PaymentsEventType: String, CaseIterable, Codable {
    case Payment
    
    public var rawValue: String {
        switch self {
        case .Payment: return "payment"
        }
    }
    
}
