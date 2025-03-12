//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class ItemEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> ViewItemObject? {
        guard let eventObject = logObject as? ViewItemObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Item.rawValue,
                paramName: "ViewItemObject",
                className: "ViewItemObject"
            )
            return nil
        }
        
        guard CoreConstants.shared.enumContains(EComItemAction.self, name: eventObject.action) else {
            ExceptionManager.throwEnumException(
                eventType: EComEventType.Item.rawValue,
                className: String(describing: EComItemAction.self)
            )
            return nil
        }
        
        if(ECommerceConstants.isItemValueObjectValid(itemValue: eventObject.item, eventType: EComEventType.Item)){
            return eventObject
        }
        
        return nil
    }
}
