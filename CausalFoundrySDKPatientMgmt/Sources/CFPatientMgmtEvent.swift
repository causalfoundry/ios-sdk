//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation
import CausalFoundrySDKCore

public class CFPatientMgmtEvent {
    public static let shared = CFPatientMgmtEvent()
    
    private init() {}
    
    
    public func logIngest<T: Codable>(eventType: PatientMgmtEventType,
                       logObject: T?,
                       isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                   eventTime: Int64? = 0){
        
        CFPatientMgmtSetupInterfaceImpl.shared.trackSDKEvent(eventType: eventType,
                                                      logObject: logObject,
                                                      isUpdateImmediately: isUpdateImmediately,
                                                      eventTime: eventTime)
    }
    
    public func logCatalog(patientMgmtCatalogType: PatientMgmtCatalogSubject, catalogModel: Any) {
        CFPatientMgmtSetupInterfaceImpl.shared.trackCatalogEvent(patientMgmtCatalogType: patientMgmtCatalogType, catalogModel: catalogModel)
    }
    
}

