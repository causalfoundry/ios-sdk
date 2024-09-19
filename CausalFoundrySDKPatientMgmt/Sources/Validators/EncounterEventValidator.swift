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
            }else if eventObject.action.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "action" , className: String(describing: HcwItemAction.self))
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: eventObject.action) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Encounter.rawValue,
                                                    className: String(describing: HcwItemAction.self))
            } else if eventObject.category.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "category" , className: String(describing: HcwSiteCategory.self))
            } else if !CoreConstants.shared.enumContains(HcwSiteCategory.self, name: eventObject.category) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Encounter.rawValue,
                                                    className: String(describing: HcwSiteCategory.self))
            } else if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "type" , className: String(describing: EncounterType.self))
            } else if !CoreConstants.shared.enumContains(EncounterType.self, name: eventObject.type) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Encounter.rawValue,
                                                    className: String(describing: EncounterType.self))
            } else if eventObject.subType.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "sub_type" , className: String(describing: DiagnosisType.self))
            } else if !CoreConstants.shared.enumContains(DiagnosisType.self, name: eventObject.subType) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Encounter.rawValue,
                                                    className: String(describing: DiagnosisType.self))
            } else if(PatientMgmtEventValidation.verifyEncounterSummaryObject(eventType: PatientMgmtEventType.Encounter, encounterSummaryObject: eventObject.encounterSummaryObject)){
                    return eventObject
            }
        }
        return nil
    }
    
    public static func mapStringToEncounterEventObject(objectString: String) -> EncounterEventObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(EncounterEventObject.self, from: data)
    }
    
}

