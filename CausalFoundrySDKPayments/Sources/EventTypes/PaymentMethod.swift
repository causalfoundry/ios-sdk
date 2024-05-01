//
//  PaymentMethod.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import CausalFoundrySDKCore
import Foundation

public enum PaymentMethod: String, EnumComposable {
    case BankTransfer
    case Cheque
    case CashOnDelivery
    case Credit
    case PointOfSale
    case BankCard
    case MobileTransfer
    case Cash
    case Wallet
    case Other
    
    
    public var rawValue: String {
        switch self {
        case .BankTransfer: return "bank_transfer"
        case .Cheque: return "cheque"
        case .CashOnDelivery: return "cod"
        case .Credit: return "credit"
        case .PointOfSale: return "pos"
        case .BankCard: return "bank_card"
        case .MobileTransfer: return "mobile_transfer"
        case .Cash: return "cash"
        case .Wallet: return "wallet"
        case .Other: return "other"
        }
    }
    
}
