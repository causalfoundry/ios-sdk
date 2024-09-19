//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 30/8/24.
//

import Foundation
import CausalFoundrySDKCore

public class PatientEventValidator {
    
    static func validatePatientObject<T:Codable>(logObject: T?) -> PatientEventObject? {
        let eventObject: PatientEventObject? = {
            if let eventObject = logObject as? PatientEventObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue,
                                                       paramName: "PatientEventObject", className: "PatientEventObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.patientId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "patientId", className: "patientId")
            } else if eventObject.siteId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "siteId", className: "siteId")
            }else if eventObject.action.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "action" , className: String(describing: HcwItemAction.self))
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: eventObject.action) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Patient.rawValue,
                                                    className: String(describing: HcwItemAction.self))
            }else if eventObject.category.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "category" , className: String(describing: HcwSiteCategory.self))
            } else if !CoreConstants.shared.enumContains(HcwSiteCategory.self, name: eventObject.category) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Patient.rawValue,
                                                    className: String(describing: HcwSiteCategory.self))
            } else if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "type" , className: String(describing: PatientType.self))
            } else if !CoreConstants.shared.enumContains(PatientType.self, name: eventObject.type) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Patient.rawValue,
                                                    className: String(describing: PatientType.self))
            } else {
                
                if(PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.Patient, diagnosisType: "Biometric", diagnosisList: eventObject.biometricList)){
                    return eventObject
                }

            }
        }
        return nil
    }
    
    public static func mapStringToPatientEventObject(objectString: String) -> PatientEventObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(PatientEventObject.self, from: data)
    }
    
}
