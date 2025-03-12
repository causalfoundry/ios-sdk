//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class ItemVerificationEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> ItemVerificationObject? {
        guard let eventObject = logObject as? ItemVerificationObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.ItemVerification.rawValue,
                paramName: "ItemVerificationObject",
                className: "ItemVerificationObject"
            )
            return nil
        }
        
        if(eventObject.isSuccessful && eventObject.itemInfo == nil){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemVerification.rawValue, elementName: "itemInfo object")
            return nil
        }else if(eventObject.isSuccessful && eventObject.itemInfo?.itemId == ""){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemVerification.rawValue, elementName: "itemInfo itemId")
            return nil
        }
        
        return eventObject
    }
}
