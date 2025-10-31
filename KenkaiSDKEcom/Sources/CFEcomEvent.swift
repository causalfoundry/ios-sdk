//
//  CFEComEvent.swift
//  KenkaiSDK
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
    
    public func logCatalog<T: Codable>(eComCatalogType: EComCatalogType, subjectId: String, catalogModel: T) {
        CFEComSetupInterfaceImpl.shared.trackCatalogEvent(eComCatalogType: eComCatalogType, subjectId: subjectId, catalogModel: catalogModel)
    }
    
}
