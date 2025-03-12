//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class ItemReportEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> ItemReportObject? {
        guard let eventObject = logObject as? ItemReportObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.ItemReport.rawValue,
                paramName: "ItemReportObject",
                className: "ItemReportObject"
            )
            return nil
        }
        
        if(!ECommerceConstants.isItemTypeObjectValid(itemValue: eventObject.item, eventType: EComEventType.ItemReport)){
            return nil
        }else if(eventObject.storeObject.id.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemReport.rawValue, elementName: "storeObject id")
            return nil
        }else if(eventObject.reportObject.id.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemReport.rawValue, elementName: "reportObject id")
            return nil
        }else if(eventObject.reportObject.shortDesc.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemReport.rawValue, elementName: "reportObject shortDesc")
            return nil
        }
        
        return eventObject
    }
}
