//
//  CFEComEvent.swift
//  CausalFoundrySDK
//
//  Created by MOIZ HASSAN KHAN on 11/3/25.
//

import Foundation

public class CFEComEvent {
    public static let shared = CFEComEvent()
    
    private init() {}
    
    
    public func logIngest<T: Codable>(eventType: EComEventType,
                                      logObject: T?,
                                      isUpdateImmediately: Bool? = nil,
                                      eventTime: Int64? = 0){
        
        CFEComSetupInterfaceImpl.shared.trackSDKEvent(eventType: eventType,
                                                      logObject: logObject,
                                                      isUpdateImmediately: isUpdateImmediately,
                                                      eventTime: eventTime)
    }
    
    public func logCatalog(catalogType: EComCatalogType, catalogModel: Any) {
        CFEComSetupInterfaceImpl.shared.trackCatalogEvent(catalogType: catalogType, catalogModel: catalogModel)
    }
    
}
