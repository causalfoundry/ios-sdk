//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class PaymentsEventValidator {
    
    static func validatePaymentsObject<T: Codable>(logObject: T?) -> PaymentObject? {
        guard let eventObject = logObject as? PaymentObject else {
            ExceptionManager.throwInvalidException(
                eventType: PaymentsEventType.Payment.rawValue,
                paramName: "DeferredPaymentObject",
                className: "DeferredPaymentObject"
            )
            return nil
        }
        
        if(eventObject.paymentId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.Payment.rawValue, elementName: "payment_id")
            return nil
        } else if(eventObject.orderId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.Payment.rawValue, elementName: "order_id")
            return nil
        } else if !CoreConstants.shared.enumContains(PaymentMethod.self, name: eventObject.method) {
            ExceptionManager.throwEnumException(eventType: PaymentsEventType.Payment.rawValue, className: "payment method")
            return nil
        } else if !CoreConstants.shared.enumContains(PaymentAction.self, name: eventObject.action) {
            ExceptionManager.throwEnumException(eventType: PaymentsEventType.Payment.rawValue, className: "payment action")
            return nil
        } else if !CoreConstants.shared.enumContains(CurrencyCode.self, name: eventObject.currency) {
            ExceptionManager.throwEnumException(eventType: PaymentsEventType.Payment.rawValue, className: "payment currency")
            return nil
        }
        
        return eventObject
    }

}
