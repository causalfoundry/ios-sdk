//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import Foundation
import CausalFoundrySDKCore

public class PatientMgmtEventValidator {
    
    static func validateAppointmentObject<T:Codable>(logObject: T?) -> AppointmentEventObject? {
        let eventObject: AppointmentEventObject? = {
            if let eventObject = logObject as? AppointmentEventObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue,
                                                       paramName: "AppointmentEventObject", className: "AppointmentEventObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.appointmentId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "appointmentId" , className: "appointmentId")
            } else if eventObject.patientId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "patientId" , className: "patientId")
            } else if eventObject.siteId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "site Id" , className: "site Id")
            } else if eventObject.location.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "location" , className: "location")
            } else if eventObject.status.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "status" , className: "status")
            } else if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "type" , className: "type")
            } else if eventObject.category.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "category" , className: "category")
            }
        }
        return nil
    }
    
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
            if eventObject.encounterId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "encounterId" , className: "encounterId")
            } else if eventObject.patientId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "patientId" , className: "patientId")
            } else if eventObject.siteId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "site Id" , className: "site Id")
            } else if eventObject.location.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "location" , className: "location")
            } else if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "type" , className: "type")
            } else if eventObject.category.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Encounter.rawValue, paramName: "category" , className: "category")
            }
        }
        return nil
    }
    
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
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "patientId" , className: "patientId")
            } else if eventObject.siteId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "site Id" , className: "site Id")
            } else if eventObject.location.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "location" , className: "location")
            } else if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue, paramName: "type" , className: "type")
            }
        }
        
        return nil
    }
    
    static func validateDiagnosisObject<T:Codable>(logObject: T?) -> DiagnosisEventObject? {
        let eventObject: DiagnosisEventObject? = {
            if let eventObject = logObject as? DiagnosisEventObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Diagnosis.rawValue,
                                                       paramName: "DiagnosisEventObject", className: "DiagnosisEventObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.encounterId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Diagnosis.rawValue, paramName: "encounterId" , className: "encounterId")
            } else if eventObject.patientId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Diagnosis.rawValue, paramName: "patientId" , className: "patientId")
            } else if eventObject.siteId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Diagnosis.rawValue, paramName: "site Id" , className: "site Id")
            } else if eventObject.location.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Diagnosis.rawValue, paramName: "location" , className: "location")
            } else if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Diagnosis.rawValue, paramName: "type" , className: "type")
            }else if eventObject.category.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Diagnosis.rawValue, paramName: "category" , className: "category")
            }
        }
        
        return nil
    }
}


