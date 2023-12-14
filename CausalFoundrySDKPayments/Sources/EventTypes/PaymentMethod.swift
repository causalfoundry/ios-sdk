//
//  PaymentMethod.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import CausalFoundrySDKCore
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
