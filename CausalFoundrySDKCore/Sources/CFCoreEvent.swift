//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation

public class CFCoreEvent {
    public static let shared = CFCoreEvent()
    
    private init() {}
    
    
    public func logIngest<T: Codable>(eventType: CoreEventType,
                                          logObject: T?,
                                          contentBlock: ContentBlock? = CoreConstants.shared.contentBlock,
                                          isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                          eventTime: Int64? = 0) {
        
        CFCoreSetupInterfaceImpl.shared.trackSDKEvent(eventType: eventType,
                                                      logObject: logObject,
                                                      contentBlock: contentBlock,
                                                      isUpdateImmediately: isUpdateImmediately,
                                                      eventTime: eventTime)
    }
    
    public func logCatalog(coreCatalogType: CoreCatalogSubject, catalogModel: Any) {
        CFCoreSetupInterfaceImpl.shared.trackCatalogEvent(coreCatalogType: coreCatalogType, catalogModel: catalogModel)
    }
    
}

