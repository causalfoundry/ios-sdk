//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation

public class MediaEventValidator {
    
    static func validateMediaObject<T:Codable>(logObject: T?) -> MediaObject? {
        let eventObject: MediaObject? = {
            if let eventObject = logObject as? MediaObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Media.rawValue,
                                                       paramName: "MediaObject", className: "MediaObject")
                return nil
            }
        }()
        if var eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.id.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Media.rawValue, elementName: "media Id")
            } else if eventObject.time < 0 {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Media.rawValue,
                                                       paramName: "media duration",
                                                       className: String(describing: Float.self))
            } else {
                
                if (eventObject.type == MediaType.Image.rawValue) {
                    eventObject.action = MediaAction.View.rawValue
                    eventObject.time = 0
                }
                
                return eventObject
            }
        }
        return nil
    }
    
    public static func mapStringToMediaObject(objectString: String) -> MediaObject? {
        guard let data = objectString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(MediaObject.self, from: data)
    }
    
}
