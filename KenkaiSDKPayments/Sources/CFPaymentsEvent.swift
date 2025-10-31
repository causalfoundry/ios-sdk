//
//  CFPaymentsEvent.swift
//  KenkaiSDK
//
//  Created by MOIZ HASSAN KHAN on 11/3/25.
//

import Foundation

public class CFPaymentsEvent {
    public static let shared = CFPaymentsEvent()
    
    private init() {}
    
    
    public func logIngest<T: Codable>(eventType: PaymentsEventType,
                                      logObject: T?,
                                      isUpdateImmediately: Bool? = nil,
                                      eventTime: Int64? = 0){
        
        CFPaymentsSetupInterfaceImpl.shared.trackSDKEvent(eventType: eventType,
                                                      logObject: logObject,
                                                      isUpdateImmediately: isUpdateImmediately,
                                                      eventTime: eventTime)
    }
    
}
