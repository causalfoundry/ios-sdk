//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation
import CausalFoundrySDKCore

internal class CFPaymentsSetupInterfaceImpl: CFPaymentsSetupInterface {
    
    
    // Singleton instance
    static let shared = CFPaymentsSetupInterfaceImpl()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    
    func trackSDKEvent<T: Codable>(eventType: PaymentsEventType,
                                   logObject: T?,
                                   isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                   eventTime: Int64? = 0) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        
        
        if let eventObject = validatePaymentsEvent(eventType: eventType, logObject: logObject){
            CFSetup().track(
                eventName: eventType.rawValue,
                eventProperty: "",
                eventCtx: eventObject,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
        }else{
            print("Unknown event object type")
        }
    }
    
    private func validatePaymentsEvent<T: Codable>(eventType: PaymentsEventType, logObject: T?) -> T? {
        switch eventType {
        case .DeferredPayment:
            return PaymentsEventValidator.validateDeferredPaymentsObject(logObject: logObject) as? T
        case .PaymentMethod:
            return PaymentsEventValidator.validatePaymentMethodObject(logObject: logObject) as? T
        }
    }
}

