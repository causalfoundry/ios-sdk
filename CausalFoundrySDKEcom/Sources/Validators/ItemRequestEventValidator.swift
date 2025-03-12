//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class ItemRequestEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> ItemRequestObject? {
        guard let eventObject = logObject as? ItemRequestObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.ItemRequest.rawValue,
                paramName: "ItemRequestObject",
                className: "ItemRequestObject"
            )
            return nil
        }
        
        if(eventObject.itemRequestId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemRequest.rawValue, elementName: "itemRequest id")
            return nil
        }else if(eventObject.itemName.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemRequest.rawValue, elementName: "itemRequest name")
            return nil
        }else if(eventObject.manufacturer.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemRequest.rawValue, elementName: "itemRequest manufacturer")
            return nil
        }
        
        return eventObject
    }
}
