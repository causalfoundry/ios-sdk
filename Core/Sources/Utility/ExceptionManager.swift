//
//  ExceptionManager.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import Network
import UIKit

struct ExceptionDataObject : Codable{
    let title: String
    let eventType: String
    let exceptionType: String
    let exceptionSource: String
    let stackTrace: String
    let ts: String
    
    init(title: String, eventType: String, exceptionType: String, exceptionSource: String, stackTrace: String, ts: String) {
        self.title = title
        self.eventType = eventType
        self.exceptionType = exceptionType
        self.exceptionSource = exceptionSource
        self.stackTrace = stackTrace
        self.ts = ts
    }
}

class ExceptionAPIHandler {
    func exceptionTrackAPI(exceptionObject: ExceptionDataObject, updateImmediately: Bool) {
        if !CoreConstants.shared.pauseSDK {
            if updateImmediately  == false {
                self.updateExceptionEvents(eventArray: [exceptionObject])
            } else {
                storeEventTrack(event: exceptionObject)
            }
        }
    }
    
    func updateExceptionEvents(eventArray:[ExceptionDataObject]) {
        var mainExceptionBody:MainExceptionBody?
        guard let applicationDelegate = CoreConstants.shared.application!.delegate else { return }
        var userId :String = CoreDataHelper.shared.fetchUserID()
        if CoreConstants.shared.isAnonymousUserAllowed {
            userId = CoreDataHelper.shared.fetchUserID(deviceID: CoreConstants.shared.deviceObject?.id ?? "")
        }
        
        if userId != ""{
            mainExceptionBody = MainExceptionBody(user_id: userId,app_info: CoreConstants.shared.appInfoObject,sdk_version: CoreConstants.shared.SDKVersion,data: eventArray)
        }
        
        // Show notification if tasks takes more then 10 seconds to complete and if allowed
        let delayTime = DispatchTime.now() + .milliseconds(NotificationConstants.shared.EXCEPTION_NOTIFICATION_INTERVAL_TIME)

        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            if NotificationConstants.shared.EXCEPTION_NOTIFICATION_ENABLED {
                self.showExceptionNotification(context: CoreConstants.shared.application!)
            }
        }
        
        do {
            try APIManager.shared.getAPIDetails(url:APIConstants.ingestExceptionEvent , params: mainExceptionBody!.dictionary, "POST", headers:nil, completion:{ (result) in
               
                
            })
    } catch {
            
        }
    }
    
   private func storeEventTrack(event:ExceptionDataObject) {
        var previousExceptions = CoreDataHelper.shared.getStoredExceptionsData()
        previousExceptions.append(event)
        CoreDataHelper.shared.writeExceptionEvents(eventArray:previousExceptions)
    }
    
    private func storeEventTrack(events:[ExceptionDataObject]) {
        var previousExceptions = CoreDataHelper.shared.getStoredExceptionsData()
        for data in events {
            previousExceptions.append(data)
        }
        CoreDataHelper.shared.writeExceptionEvents(eventArray:previousExceptions)
    }
    
    
    private func showExceptionNotification(context:UIApplication) {
        // need to implement code to show Notification
    }
}


class ExceptionManager {
    static func throwEnumException(eventType: String, className: String) {
        let msg = "Invalid \(className) provided"
        let exception = IllegalArgumentException(msg)
        callExceptionAPI(
            title: msg,
            eventType: eventType,
            exceptionType: "IllegalArgumentException",
            stackTrace: exception
        )
    }
    
    static func throwInvalidException(eventType: String, paramName: String) {
        let msg = "Invalid \(paramName) provided"
        let exception = IllegalArgumentException(msg)
        callExceptionAPI(
            title: msg,
            eventType: eventType,
            exceptionType: "IllegalArgumentException",
            stackTrace: exception
        )
    }
    
    static func throwInitException(eventType: String) {
        let msg = "init is required to provide context."
        let exception = NullPointerException(msg)
        callExceptionAPI(title: msg, eventType: eventType, exceptionType: "NullPointerException", stackTrace: exception)
    }
    
    
    static func throwIsRequiredException(eventType: String, elementName: String) {
        let msg = "\(elementName) is required."
        let exception = RuntimeException(msg)
        callExceptionAPI(title: msg, eventType: eventType, exceptionType: "NullPointerException", stackTrace: exception)
    }
    
    
    static func throwAPIFailException(apiName: String, response: HTTPURLResponse?, responseBody: Data?) {
        let statusCode = response?.statusCode ?? -1
        let responseBodyString = String(data: responseBody ?? Data(), encoding: .utf8) ?? "nil"
        let msg = "\(statusCode): \(responseBodyString)"
        let exception = RuntimeException(msg)
        callExceptionAPI(title: msg, eventType: apiName, exceptionType: "NullPointerException", stackTrace: exception)
    }
    
    static func throwRuntimeException(eventType: String, message: String) {
        let exception = RuntimeException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "RuntimeException", stackTrace: exception)
    }
    
    static func throwIllegalStateException(eventType: String, message: String) {
        let exception = IllegalStateException(message)
        ExceptionManager.callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalStateException", stackTrace: exception)
    }
    
    static func throwPageNumberException(eventType: String) {
        let message = "Page numbers should not be less than 1"
        let exception = IllegalArgumentException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalArgumentException", stackTrace: exception)
    }
    
    static func throwItemQuantityException(eventType: String) {
        let message = "Item Quantity should be 0 or greater than 0"
        let exception = IllegalArgumentException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalArgumentException", stackTrace: exception)
    }
    
    static func throwCurrencyNotSameException(eventType: String, valueName: String) {
        let message = "Currency for \(valueName) and item(s) should be same."
        let exception = IllegalArgumentException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalArgumentException", stackTrace: exception)
    }
    
    static func throwInvalidNudgeException(message: String, nudgeObject: String) {
        let exception = IllegalArgumentException(message)
        
        let exceptionDataObject = ExceptionDataObject(
            title: message,
            eventType: CoreEventType.nudge_response.rawValue,
            exceptionType: "IllegalArgumentException",
            exceptionSource: "SDK",
            stackTrace: "Nudge Object:\n\(nudgeObject) \n\nException:\n\(exception)",
            ts: Date().timeIntervalSince1970.convertMillisToTimeString()
        )
        
        if let application = CoreConstants.shared.application {
            ExceptionAPIHandler().exceptionTrackAPI(
                exceptionObject: exceptionDataObject,
                updateImmediately: false
            )
        }
    }
    
    static func throwInvalidNetworkException(message: String, speed: Int) {
        let exception = IllegalArgumentException(message)
        
        let exceptionDataObject = ExceptionDataObject(
            title: message,
            eventType: CoreEventType.app.rawValue,
            exceptionType: "IllegalArgumentException",
            exceptionSource: "SDK",
            stackTrace: "Value: \(speed) \n\nException:\n\(exception)",
            ts: Date().timeIntervalSince1970.convertMillisToTimeString()
        )
        
        if CoreConstants.shared.application != nil {
            ExceptionAPIHandler().exceptionTrackAPI(
                exceptionObject: exceptionDataObject,
                updateImmediately: false
            )
        }
    }
    
    func throwInternalCrashException(eventType: String, message: String, exception: Error) {
        let exceptionDataObject = ExceptionDataObject(
            title: message,
            eventType: eventType,
            exceptionType: "RuntimeException",
            exceptionSource: "SDK",
            stackTrace: exception.localizedDescription,
            ts: Date().timeIntervalSince1970.convertMillisToTimeString()
        )
        
        if CoreConstants.shared.application != nil {
            ExceptionAPIHandler().exceptionTrackAPI(
                exceptionObject: exceptionDataObject,
                updateImmediately: false
            )
        }
    }
    
    // Other exception throwing functions...
    
    private static func callExceptionAPI (
        title: String,
        eventType: String,
        exceptionType: String,
        stackTrace: ExceptionError
    ) {
        let exceptionDataObject = ExceptionDataObject(
            title: title,
            eventType: eventType,
            exceptionType: exceptionType,
            exceptionSource: "SDK",
            stackTrace: stackTrace.localizedDescription,
            ts: Date().timeIntervalSince1970.convertMillisToTimeString()
        )
        
        if CoreConstants.shared.application != nil {
            ExceptionAPIHandler().exceptionTrackAPI(exceptionObject: exceptionDataObject, updateImmediately: false)
        }
        
        if CoreConstants.shared.isDebugMode && CoreConstants.shared.isAppDebuggable {
            // Handle debug mode throwing exception
           // fatalError(stackTrace.localizedDescription)
        }
    }
}



extension TimeInterval {
    func convertMillisToTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        var date: Date
        date = Date(timeIntervalSince1970: self * 1000) // Convert milliseconds to seconds
        return dateFormatter.string(from: date)
    }
}


