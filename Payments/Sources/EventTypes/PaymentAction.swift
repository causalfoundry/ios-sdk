//
//  PaymentAction.swift
//
//
//  Created by moizhassankh on 07/12/23.
//
import CausalFoundrySDKCore
import Foundation

public enum PaymentAction: String, EnumComposable {
    case view
    case add
    case remove
    case update
    case select
    case payment_processed
}
