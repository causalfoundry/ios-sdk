//
//  File.swift
//  
//
//  Created by khushbu on 12/09/23.
//

import Foundation



class ExceptionManager {
    
    static let shared = ExceptionManager()
    
    func  throwEnumException(eventType: String, className: String) {
           // Thraw Execption
        // Call Exception API
        }
    
    func throwInitException(eventType: String) {
//            var msg = "init is required to provide context."
//            val exception = NullPointerException(msg)
//            callExceptionAPI(
//                title = msg,
//                eventType = eventType,
//                exceptionType = "NullPointerException",
//                stackTrace = exception
//            )
        }
    
    func throwIsRequiredException(eventType: String, elementName: String) {
//        var msg = "\(elementName) is required."
//        var exception = NullPointerException(msg)
    }
    
    
    private func callExceptionAPI(title:String,
                                  eventType: String,
                                  exceptionType: String,
                                  stackTrace: String) {
        
    }

    func throwInvalidException(eventType: String, paramName: String) {
//            var msg = "Invalid \(paramName) provided"
//            var exception = IllegalArgumentException(msg)
//            callExceptionAPI(
//                title = msg,
//                eventType = eventType,
//                exceptionType = "IllegalArgumentException",
//                stackTrace = exception
//            )
        }
    
    
}
