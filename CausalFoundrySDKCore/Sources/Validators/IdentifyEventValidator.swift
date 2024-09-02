//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation

public class IdentifyEventValidator {
    
    static func validateIdentifyObject<T:Codable>(logObject: T?) -> IdentifyObject? {
        
        let eventObject: IdentifyObject? = {
            if let eventObject = logObject as? IdentifyObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Identify.rawValue,
                                                       paramName: "IdentifyObject", className: "IdentifyObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.userId == nil || eventObject.userId!.isEmpty {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Identify.rawValue,
                                                       paramName: "userId",
                                                       className: "userId")
            } else if eventObject.action.isEmpty {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Identify.rawValue,
                                                       paramName: "action",
                                                       className: "action")
            }else if !CoreConstants.shared.enumContains(IdentityAction.self, name: eventObject.action) {
                ExceptionManager.throwEnumException(eventType: CoreEventType.Identify.rawValue,
                                                    className: String(describing: IdentityAction.self))
            }else if [IdentityAction.Blocked.rawValue, IdentityAction.Unblocked.rawValue].contains(eventObject.action),
                     eventObject.blocked?.reason.isEmpty ?? true {
                
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Identify.rawValue,
                                                       paramName: "blocked object reason",
                                                       className: "blocked object reason")
            } else {
                
                if eventObject.action == IdentityAction.Logout.rawValue {
                    CoreConstants.shared.logoutEvent = true
                }else{
                    CFSetup().updateUserId(appUserId: eventObject.userId!)
                }
                
                return eventObject
            }
        }
        return nil
    }
    
    public static func mapStringToInternalIdentifyObject(objectString: String) -> IdentifyObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(InternalIdentifyObject.self, from: data).toIdentifyObject()
    }
    
}
