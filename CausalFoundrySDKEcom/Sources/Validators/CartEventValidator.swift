//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class CartEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> CartObject? {
        guard let eventObject = logObject as? CartObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Cart.rawValue,
                paramName: "CartObject",
                className: "CartObject"
            )
            return nil
        }
        
        guard !eventObject.cartId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Cart.rawValue, elementName: "cartId")
            return nil
        }
        
        guard eventObject.cartPrice >= 0 else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Cart.rawValue, elementName: "cartPrice")
            return nil
        }
        
        guard eventObject.currency == eventObject.item.currency else {
            ExceptionManager.throwCurrencyNotSameException(eventType: EComEventType.Cart.rawValue, valueName: "currency")
            return nil
        }
        
        if(ECommerceConstants.isItemValueObjectValid(itemValue: eventObject.item, eventType: EComEventType.Cart)){
            return eventObject
        }
        
        return nil
    }
}
