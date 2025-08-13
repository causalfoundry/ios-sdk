//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation
import CausalFoundrySDKCore

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
        
    
        if let eventObject = validatePatientMgmtEvent(eventType: eventType, logObject: logObject){
            CFSetup().track(
                eventName: eventType.rawValue,
                eventProperty: "",
                eventCtx: eventObject,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
        }else{
            print("Unknown event object type")
        }
    }
    
    func trackCatalogEvent(patientMgmtCatalogType: PatientMgmtCatalogSubject, catalogModel: Any) {
        if CoreConstants.shared.pauseSDK{
            return
        }
        switch patientMgmtCatalogType {
        case .UserHcw:
            switch catalogModel {
            case let catalogObject as HcwCatalogModel:
                CfPatientMgmtCatalog.updateHcwCatalog(hcwCatalogModel: catalogObject)
            default:
                ExceptionManager.throwInvalidException(
                    eventType: "Hcw Catalog", paramName: "HcwCatalogModel", className: String(describing: HcwCatalogModel.self)
                )
            }
        case .Patient:
            switch catalogModel {
            case let catalogObject as PatientCatalogModel:
                CfPatientMgmtCatalog.updatePatientCatalog(patientCatalogModel: catalogObject)
            default:
                ExceptionManager.throwInvalidException(
                    eventType: "Patient Catalog", paramName: "PatientCatalogModel", className: String(describing: PatientCatalogModel.self)
                )
            }
            
        }
    }
        
    func validatePatientMgmtEvent<T: Codable>(eventType: PatientMgmtEventType, logObject: T?) -> T? {
        switch eventType {
        case .Patient:
            return PatientEventValidator.validatePatientObject(logObject: logObject) as? T
        case .Encounter:
            return EncounterEventValidator.validateEncounterObject(logObject: logObject) as? T
        case .Appointment:
            return AppointmentEventValidator.validateAppointmentObject(logObject: logObject) as? T
        }
    }
    
}
