//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation

public class RateEventValidator {

    static func validateRateObject<T:Codable>(logObject: T?) -> RateObject? {
        let eventObject: RateObject? = {
            if let eventObject = logObject as? RateObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Rate.rawValue,
                                                       paramName: "RateObject", className: "RateObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.subjectId.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Rate.rawValue, elementName: "rate subject Id")
            }else if eventObject.type.isEmpty {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Rate.rawValue,
                                                       paramName: String(describing: RateType.self),
                                                       className: String(describing: RateType.self))
            } else if !CoreConstants.shared.enumContains(RateType.self, name: eventObject.type) {
                ExceptionManager.throwEnumException(eventType: CoreEventType.Rate.rawValue,
                                                       className: String(describing: RateType.self))
            } else if eventObject.rateValue < 0 {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Rate.rawValue,
                                                       paramName: "rate value",
                                                       className: String(describing: Int.self))
            } else {
                return eventObject
            }
        }
        return nil
    }
    
    public static func mapStringToRateObject(objectString: String) -> RateObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(RateObject.self, from: data)
    }

}
