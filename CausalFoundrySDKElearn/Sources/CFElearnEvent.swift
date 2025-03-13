//
//  CFELearnEvent.swift
//  CausalFoundrySDK
//
//  Created by MOIZ HASSAN KHAN on 11/3/25.
//

import Foundation

public class CFELearnEvent {
    public static let shared = CFELearnEvent()
    
    private init() {}
    
    
    public func logIngest<T: Codable>(eventType: ELearnEventType,
                                      logObject: T?,
                                      isUpdateImmediately: Bool? = nil,
                                      eventTime: Int64? = 0){
        
        CFELearnSetupInterfaceImpl.shared.trackSDKEvent(eventType: eventType,
                                                      logObject: logObject,
                                                      isUpdateImmediately: isUpdateImmediately,
                                                      eventTime: eventTime)
    }
    
}
