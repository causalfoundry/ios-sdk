//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class CheckoutEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> CheckoutObject? {
        guard let eventObject = logObject as? CheckoutObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Checkout.rawValue,
                paramName: "CheckoutObject",
                className: "CheckoutObject"
            )
            return nil
        }
        
        guard !eventObject.orderId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "orderId")
            return nil
        }
        
        guard !eventObject.cartId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "cartId")
            return nil
        }
        
        guard eventObject.cartPrice >= 0 else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "cartPrice")
            return nil
        }
        
        guard !eventObject.itemList.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "itemList")
            return nil
        }
        
        for item in eventObject.itemList {
            if(!ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.Checkout)){
                return nil
            }
            if (eventObject.currency != item.currency) {
                ExceptionManager.throwCurrencyNotSameException(eventType: EComEventType.Checkout.rawValue, valueName: "checkout")
                return nil
            }
        }
        
        return eventObject
    }
}
