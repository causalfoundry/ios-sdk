//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 29/8/24.
//

import Foundation

public class ModuleSelectionEventValidator {

    static func validateModuleSelectionObject<T:Codable>(logObject: T?) -> ModuleSelectionObject? {
        guard let eventObject = logObject as? ModuleSelectionObject else {
            ExceptionManager.throwInvalidException(
                eventType: CoreEventType.ModuleSelection.rawValue,
                paramName: "ModuleSelectionObject",
                className: "ModuleSelectionObject"
            )
            return nil
        }
        return eventObject
    }

}
