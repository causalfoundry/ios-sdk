//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 2/9/24.
//

import Foundation
import CausalFoundrySDKCore

public class AppointmentEventValidator {
    
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
            if eventObject.patientId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "patientId" , className: "patientId")
            } else if eventObject.siteId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "site Id" , className: "site Id")
            } else if eventObject.action.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "action" , className: String(describing: HcwItemAction.self))
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: eventObject.action) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Appointment.rawValue,
                                                    className: String(describing: HcwItemAction.self))
            } else if eventObject.appointment.appointmentId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "appointmentId" , className: "appointmentId")
            } else if eventObject.appointment.hcwId.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "hcwId" , className: "hcwId")
            } else if eventObject.appointment.category.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "appointment category" , className: String(describing: HcwSiteCategory.self))
            } else if !CoreConstants.shared.enumContains(HcwSiteCategory.self, name: eventObject.appointment.category) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Appointment.rawValue,
                                                    className: String(describing: HcwSiteCategory.self))
            } else if eventObject.appointment.status.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Appointment.rawValue, paramName: "appointment status" , className: "appointment status")
            } else if !CoreConstants.shared.enumContains(AppointmentStatus.self, name: eventObject.appointment.status) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Appointment.rawValue,
                                                    className: String(describing: AppointmentStatus.self))
            } else if(
                PatientMgmtEventValidation.verifyAppointmentTypeList(eventType: PatientMgmtEventType.Appointment, typeList: eventObject.appointment.typeList)
                && PatientMgmtEventValidation.verifyAppointmentSubTypeList(eventType: PatientMgmtEventType.Appointment, subTypeList: eventObject.appointment.subTypeList)
                && PatientMgmtEventValidation.verifyAppointmentUpdateItem(eventType: PatientMgmtEventType.Appointment, updateItem: eventObject.appointment.update)
                && PatientMgmtEventValidation.verifyMissedAppointmentUpdateItem(eventType: PatientMgmtEventType.Appointment, missedItem: eventObject.appointment.missed)){
                    return eventObject
            }
        }
        return nil
    }
    
    public static func mapStringToAppointmentEventObject(objectString: String) -> AppointmentEventObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(AppointmentEventObject.self, from: data)
    }
    
}


