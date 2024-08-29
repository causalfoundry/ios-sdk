//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 29/8/24.
//

import Foundation
import CausalFoundrySDKCore

public class ModuleSelectionEventValidator {

    static func validateModuleSelectionObject<T:Codable>(logObject: T?) -> HcwModuleObject? {
        let eventObject: HcwModuleObject? = {
            if let eventObject = logObject as? HcwModuleObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue,
                                                       paramName: "HcwModuleObject", className: "HcwModuleObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: PatientMgmtEventType.Patient.rawValue,
                                                       paramName: String(describing: AppAction.self),
                                                       className: String(describing: AppAction.self))
            } else if !CoreConstants.shared.enumContains(PatientModuleType.self, name: eventObject.type) {
                ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.Patient.rawValue,
                                                       className: String(describing: PatientModuleType.self))
            } else {
                return eventObject
            }
        }
        return nil
    }
    
    public static func mapStringToHcwModuleObject(objectString: String) -> HcwModuleObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(HcwModuleObject.self, from: data)
    }

}
