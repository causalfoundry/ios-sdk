//
//  EComEventType.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation


enum EComEventType: String {
    // E Commerce
    case item = "item"
    case delivery = "delivery"
    case checkout = "checkout"
    case cart = "cart"
    case scheduleDelivery = "schedule_delivery"
    case cancelCheckout = "cancel_checkout"
    case itemReport = "item_report"
    case itemVerification = "item_verification"
    case itemRequest = "item_request"
}
