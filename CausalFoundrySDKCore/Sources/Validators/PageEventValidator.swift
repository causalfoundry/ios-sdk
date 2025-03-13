//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation

public class PageEventValidator {

    static func validatePageObject<T:Codable>(logObject: T?) -> PageObject? {
        
        let eventObject: PageObject? = {
            if let eventObject = logObject as? PageObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Page.rawValue,
                                                       paramName: "PageObject", className: "PageObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.path.isEmpty {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Page.rawValue,
                                                       paramName: "path",
                                                       className: "path")
            } else if eventObject.title.isEmpty {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Page.rawValue,
                                                       paramName: "title",
                                                       className: "title")
            } else if eventObject.duration < 0 {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Page.rawValue,
                                                       paramName: "duration",
                                                       className: "duration")
            }  else if eventObject.renderTime < 0 {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Page.rawValue,
                                                       paramName: "render_time",
                                                       className: "render_time")
            } else {
                return eventObject
            }
        }
        return nil
    }

}
