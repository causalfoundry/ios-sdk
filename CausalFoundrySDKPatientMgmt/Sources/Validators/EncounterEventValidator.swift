//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import Foundation
import CausalFoundrySDKCore

public class EncounterEventValidator {
    
    static func validateEncounterObject<T:Codable>(logObject: T?) -> EncounterEventObject? {
        let eventObject: EncounterEventObject? = {
            if let eventObject = logObject as? EncounterEventObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue,
                                                       paramName: "EncounterEventObject", className: "EncounterEventObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.patientId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "patientId", className: "patientId")
            } else if eventObject.siteId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "siteId", className: "siteId")
            } else if(PatientMgmtEventValidation.verifyEncounterSummaryObject(eventType: PatientMgmtEventType.Encounter, encounterSummaryObject: eventObject.encounterSummaryObject)){
                    return eventObject
            }
        }
        return nil
    }
    
}

