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
            } else {
                
                if(PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.Patient, diagnosisType: "Biometric", diagnosisList: eventObject.biometricList)){
                    return eventObject
                }

            }
        }
        return nil
    }
}
