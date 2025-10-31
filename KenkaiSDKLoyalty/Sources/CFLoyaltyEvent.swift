//
//  CFLoyaltyEvent.swift
//  KenkaiSDK
//
//  Created by MOIZ HASSAN KHAN on 11/3/25.
//

import Foundation

public class CFLoyaltyEvent {
    public static let shared = CFLoyaltyEvent()
    
    private init() {}
    
    
    public func logIngest<T: Codable>(eventType: LoyaltyEventType,
                                      logObject: T?,
                                      isUpdateImmediately: Bool? = nil,
                                      eventTime: Int64? = 0){
        
        CFLoyaltySetupInterfaceImpl.shared.trackSDKEvent(eventType: eventType,
                                                      logObject: logObject,
                                                      isUpdateImmediately: isUpdateImmediately,
                                                      eventTime: eventTime)
    }
    
    public func logCatalog<T: Codable>(loyaltyCatalogType: LoyaltyCatalogType, subjectId: String, catalogModel: T) {
        CFLoyaltySetupInterfaceImpl.shared.trackCatalogEvent(loyaltyCatalogType: loyaltyCatalogType, subjectId: subjectId, catalogModel: catalogModel)
    }
    
}
