//
//  PaymentMethod.swift
//
//
//  Created by khushbu on 02/11/23.

import CasualFoundryCore
import Foundation

public enum PaymentMethod: String, Codable, EnumComposable {
    case bank_transfer
    case cheque
    case cod
    case credit
    case pos
    case bank_card
    case other
}
