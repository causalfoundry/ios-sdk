//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation
import CausalFoundrySDKCore

internal class CFEComSetupInterfaceImpl: CFEComSetupInterface {
    
    
    // Singleton instance
    static let shared = CFEComSetupInterfaceImpl()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    
    func trackSDKEvent<T: Codable>(eventType: EComEventType,
                                   logObject: T?,
                                   isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                   eventTime: Int64? = 0) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        
        
        if let eventObject = validateEComEvent(eventType: eventType, logObject: logObject){
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
    
    func trackCatalogEvent(catalogType: EComCatalogType, catalogModel: Any) {
        if CoreConstants.shared.pauseSDK{
            return
        }
        CfEComCatalog.callCatalogAPI(catalogType: catalogType, catalogModel: catalogModel)
    }
    
    
    private func validateEComEvent<T: Codable>(eventType: EComEventType, logObject: T?) -> T? {
        switch eventType {
        case .Item:
            return ItemEventValidator.validateEvent(logObject: logObject) as? T
        case .Cart:
            return CartEventValidator.validateEvent(logObject: logObject) as? T
        case .Checkout:
            return CheckoutEventValidator.validateEvent(logObject: logObject) as? T
        case .CancelCheckout:
            return CancelCheckoutEventValidator.validateEvent(logObject: logObject) as? T
        case .Delivery:
            return DeliveryEventValidator.validateEvent(logObject: logObject) as? T
        case .ItemReport:
            return ItemReportEventValidator.validateEvent(logObject: logObject) as? T
        case .ItemRequest:
            return ItemRequestEventValidator.validateEvent(logObject: logObject) as? T
        case .ItemVerification:
            return ItemVerificationEventValidator.validateEvent(logObject: logObject) as? T
        }
    }
}

