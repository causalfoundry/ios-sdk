//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class PaymentsEventValidator {
    
    static func validateDeferredPaymentsObject<T: Codable>(logObject: T?) -> DeferredPaymentObject? {
        guard let eventObject = logObject as? DeferredPaymentObject else {
            ExceptionManager.throwInvalidException(
                eventType: PaymentsEventType.DeferredPayment.rawValue,
                paramName: "DeferredPaymentObject",
                className: "DeferredPaymentObject"
            )
            return nil
        }
        
        if(eventObject.paymentId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.DeferredPayment.rawValue, elementName: "payment_id")
            return nil
        } else if(eventObject.orderId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.DeferredPayment.rawValue, elementName: "order_id")
            return nil
        }
        
        return eventObject
    }
    
    static func validatePaymentMethodObject<T: Codable>(logObject: T?) -> PaymentMethodObject? {
        guard let eventObject = logObject as? PaymentMethodObject else {
            ExceptionManager.throwInvalidException(
                eventType: PaymentsEventType.PaymentMethod.rawValue,
                paramName: "PaymentMethodObject",
                className: "PaymentMethodObject"
            )
            return nil
        }
        
        if(eventObject.paymentId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.PaymentMethod.rawValue, elementName: "payment_id")
            return nil
        } else if(eventObject.orderId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.PaymentMethod.rawValue, elementName: "order_id")
            return nil
        }
        return eventObject
    }

}
