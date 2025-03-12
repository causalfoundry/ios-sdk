//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class CancelCheckoutEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> CancelCheckoutObject? {
        guard let eventObject = logObject as? CancelCheckoutObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.CancelCheckout.rawValue,
                paramName: "CancelCheckoutObject",
                className: "CancelCheckoutObject"
            )
            return nil
        }
        
        guard !eventObject.checkoutId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "checkoutId")
            return nil
        }
        
        guard !eventObject.itemList.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "itemList")
            return nil
        }
        
        for item in eventObject.itemList {
            if(!ECommerceConstants.isItemTypeObjectValid(itemValue: item, eventType: EComEventType.CancelCheckout)){
                return nil
            }
        }
        
        return eventObject
    }
}
