//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class DeliveryEventValidator {
    
    static func validateEvent<T: Codable>(logObject: T?) -> DeliveryObject? {
        guard let eventObject = logObject as? DeliveryObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Delivery.rawValue,
                paramName: "DeliveryObject",
                className: "DeliveryObject"
            )
            return nil
        }
        
        guard !eventObject.orderId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Delivery.rawValue, elementName: "orderId")
            return nil
        }
        
        guard !eventObject.deliveryId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Delivery.rawValue, elementName: "deliveryId")
            return nil
        }
        
        if (eventObject.deliveryCoordinates != nil && (eventObject.deliveryCoordinates?.lat == 0 || eventObject.deliveryCoordinates?.lon == 0)) {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Delivery.rawValue, elementName: "deliveryCoordinates")
            return nil
        }
        
        if (eventObject.dispatchCoordinates != nil && (eventObject.dispatchCoordinates?.lat == 0 || eventObject.dispatchCoordinates?.lon == 0)) {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Delivery.rawValue, elementName: "dispatchCoordinates")
            return nil
        }
        
        return eventObject
    }
}
