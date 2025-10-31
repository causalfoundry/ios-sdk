//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation
import KenkaiSDKCore

internal class CFPatientMgmtSetupInterfaceImpl: CFPatientMgmtSetupInterface {
    
    
    // Singleton instance
    static let shared = CFPatientMgmtSetupInterfaceImpl()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    
    func trackSDKEvent<T: Codable>(eventType: PatientMgmtEventType,
                                   logObject: T?,
                                   isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                   eventTime: Int64? = 0) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        
        
        validatePatientMgmtEvent(eventType: eventType, logObject: logObject, isUpdateImmediately: isUpdateImmediately, eventTime: eventTime)
    }
    
    func trackCatalogEvent<T: Codable>(patientMgmtCatalogType: PatientMgmtCatalogType, subjectId: String, catalogModel: T) {
        if CoreConstants.shared.pauseSDK{
            return
        }
        
        var subject: CatalogSubject? = nil
        var catalogData: Codable? = nil
        
        switch(patientMgmtCatalogType){
        case .UserHcw:
            if let model = catalogModel as? HcwCatalogModel {
                subject = .user_chw
                catalogData = PatientMgmtConstants.verifyHcwCatalog(hcwId:subjectId, hcwCatalogModel: model)
            }
        case .Patient:
            if let model = catalogModel as? PatientCatalogModel {
                subject = .patient
                catalogData = PatientMgmtConstants.verifyPatientCatalog(patientId: subjectId, patientCatalogModel: model)
            }
        }
        
        if let subject = subject, let catalogData = catalogData {
            CFSetup().updateCatalogItem(subject: subject, subjectId: subjectId, catalogObject: catalogData)
        } else {
            ExceptionManager.throwIllegalStateException(
                eventType: "patient mgmt catalog",
                message: "Please use correct catalog properties with provided item type",
                className: "CFPatientMgmtCatalog"
            )
        }
    }
    
    func validatePatientMgmtEvent<T: Codable>(eventType: PatientMgmtEventType, logObject: T?, isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                              eventTime: Int64? = 0) {
        switch eventType {
        case .Patient:
            if let eventObject = PatientMgmtEventValidator.validatePatientObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Encounter:
            if let eventObject = PatientMgmtEventValidator.validateEncounterObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Appointment:
            if let eventObject = PatientMgmtEventValidator.validateAppointmentObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Diagnosis:
            if let eventObject = PatientMgmtEventValidator.validateDiagnosisObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.name,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        }
    }
    
}
