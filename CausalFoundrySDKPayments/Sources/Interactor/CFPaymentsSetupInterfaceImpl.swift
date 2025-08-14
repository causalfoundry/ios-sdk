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
        validatePaymentsEvent(eventType: eventType, logObject: logObject, isUpdateImmediately: isUpdateImmediately, eventTime: eventTime)
    }
    
    private func validatePaymentsEvent<T: Codable>(eventType: PaymentsEventType, logObject: T?, isUpdateImmediately: Bool?, eventTime: Int64?) {
        switch eventType {
        case .Payment:
            if let eventObject = PaymentsEventValidator.validatePaymentsObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        }
    }
}

