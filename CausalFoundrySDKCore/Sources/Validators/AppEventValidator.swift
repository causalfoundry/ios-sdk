//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation

public class AppEventValidator {

    static func validateAppObject<T:Codable>(logObject: T?) -> AppObject? {
        let appObject: AppObject? = {
            if let appObject = logObject as? AppObject {
                return appObject
            } else {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.App.rawValue,
                                                       paramName: "AppObject", className: "AppObject")
                return nil
            }
        }()
        if let appObject = appObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if appObject.action!.isEmpty {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.App.rawValue,
                                                       paramName: String(describing: AppAction.self),
                                                       className: String(describing: AppAction.self))
            } else if !CoreConstants.shared.enumContains(AppAction.self, name: appObject.action) {
                ExceptionManager.throwEnumException(eventType: CoreEventType.App.rawValue,
                                                       className: String(describing: AppAction.self))
            } else if appObject.startTime! < 0 {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.App.rawValue,
                                                       paramName: "startTime",
                                                       className: String(describing: Int.self))
            } else {
                return appObject
            }
        }
        return nil
    }
    
    public static func mapStringToAppObject(objectString: String) -> AppObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(AppObject.self, from: data)
    }

}
