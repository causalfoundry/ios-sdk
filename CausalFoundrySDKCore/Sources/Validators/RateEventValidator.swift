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

}
