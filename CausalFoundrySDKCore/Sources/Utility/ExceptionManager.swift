//
//  ExceptionManager.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import Network

struct ExceptionDataObject: Codable, Hashable {
    let title: String?
    let eventType: String?
    let exceptionType: String?
    let exceptionSource: String?
    let stackTrace: String?
    let ts: String?

    enum CodingKeys: String, CodingKey {
        case title
        case eventType = "event_type"
        case exceptionType = "exception_type"
        case exceptionSource = "exception_source"
        case stackTrace = "stack_trace"
        case ts
    }

    init(title: String?, eventType: String?, exceptionType: String?, exceptionSource: String?, stackTrace: String?, ts: String?) {
        self.title = title
        self.eventType = eventType
        self.exceptionType = exceptionType
        self.exceptionSource = exceptionSource
        self.stackTrace = stackTrace
        self.ts = ts
    }
    
    // Computed property to check if `type` or `stack` is nil or empty
    var isTypeOrPropsEmpty: Bool {
        let optionalStrings: [String?] = [eventType, exceptionType, exceptionSource]
        return optionalStrings.contains(where: { $0?.isEmpty ?? true })
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(eventType)
        hasher.combine(exceptionType)
        hasher.combine(exceptionSource)
        hasher.combine(stackTrace)
        hasher.combine(ts)
    }

    static func == (lhs: ExceptionDataObject, rhs: ExceptionDataObject) -> Bool {
        return lhs.title == rhs.title &&
               lhs.eventType == rhs.eventType &&
               lhs.exceptionType == rhs.exceptionType &&
               lhs.exceptionSource == rhs.exceptionSource &&
               lhs.stackTrace == rhs.stackTrace &&
               lhs.ts == rhs.ts
    }
    
}

class ExceptionAPIHandler {
    func exceptionTrackAPI(exceptionObject: ExceptionDataObject, updateImmediately: Bool) {
        if #available(iOS 13.0, *) {
            guard !CoreConstants.shared.pauseSDK else { return }
            if updateImmediately {
                updateExceptionEvents(eventArray: [exceptionObject]) { [weak self] success in
                    if !success {
                        self?.storeEventTrack(event: exceptionObject)
                    }
                }
            } else {
                storeEventTrack(event: exceptionObject)
            }
        }
    }

    func updateExceptionEvents(eventArray: [ExceptionDataObject], completion: @escaping (_ success: Bool) -> Void) {
        if #available(iOS 13.0, *) {
            var userId = CoreConstants.shared.userId
            
            if(userId == nil || userId?.isEmpty == true){
                userId = MMKVHelper.shared.fetchUserBackupID()
            }
            
            if(userId ==  nil || userId?.isEmpty == true){
                userId = CoreConstants.shared.deviceObject?.id
            }
            
            let mainExceptionBody = MainExceptionBody(user_id: userId, device_info: CoreConstants.shared.deviceObject, app_info: CoreConstants.shared.appInfoObject, sdk_version: CoreConstants.shared.SDKVersion, data: eventArray)
            
            let dictionary = mainExceptionBody.dictionary
            
            let url = URL(string: APIConstants.ingestExceptionEvent)!
            BackgroundRequestController.shared.request(url: url, httpMethod: .post, params: dictionary) { result in
                switch result {
                case .success:
                    MMKVHelper.shared.deleteExceptionEvents()
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }

    private func storeEventTrack(event: ExceptionDataObject) {
        if #available(iOS 13.0, *) {
            var previousExceptions = MMKVHelper.shared.readExceptionsData()
            previousExceptions.append(event)
            MMKVHelper.shared.writeExceptionEvents(eventArray: previousExceptions)
        }
    }

    private func storeEventTrack(events: [ExceptionDataObject]) {
        if #available(iOS 13.0, *) {
            var previousExceptions = MMKVHelper.shared.readExceptionsData()
            for data in events {
                previousExceptions.append(data)
            }
            MMKVHelper.shared.writeExceptionEvents(eventArray: previousExceptions)
        }
    }
}

public enum ExceptionManager {
    public static func throwEnumException(eventType: String, className: String) {
        let msg = "Invalid \(className) provided"
        let exception = IllegalArgumentException(msg)
        callExceptionAPI(
            title: msg,
            eventType: eventType,
            exceptionType: "IllegalArgumentException",
            stackTrace: exception
        )
    }

    public static func throwInvalidException(eventType: String, paramName: String, className: String) {
        let line = #line
        let msg = "Invalid \(paramName) provided at \(line) in \(className)"
        let exception = IllegalArgumentException(msg)
        callExceptionAPI(
            title: msg,
            eventType: eventType,
            exceptionType: "IllegalArgumentException",
            stackTrace: exception
        )
    }

    public static func throwInitException(eventType: String) {
        let msg = "init is required to provide context."
        let exception = NullPointerException(msg)
        callExceptionAPI(title: msg, eventType: eventType, exceptionType: "NullPointerException", stackTrace: exception)
    }

    public static func throwIsRequiredException(eventType: String, elementName: String) {
        let msg = "\(elementName) is required."
        let exception = RuntimeException(msg)
        callExceptionAPI(title: msg, eventType: eventType, exceptionType: "NullPointerException", stackTrace: exception)
    }

    public static func throwAPIFailException(apiName: String, response: HTTPURLResponse?, responseBody: Data?) {
        let statusCode = response?.statusCode ?? -1
        let responseBodyString = String(data: responseBody ?? Data(), encoding: .utf8) ?? "nil"
        let msg = "\(statusCode): \(responseBodyString)"
        let exception = RuntimeException(msg)
        callExceptionAPI(title: msg, eventType: apiName, exceptionType: "NullPointerException", stackTrace: exception)
    }

    public static func throwRuntimeException(eventType: String, message: String) {
        let exception = RuntimeException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "RuntimeException", stackTrace: exception)
    }

    public static func throwIllegalStateException(eventType: String, message: String, className _: String) {
        // let lineNumber = #line
        let exception = IllegalStateException(message)
        ExceptionManager.callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalStateException", stackTrace: exception)
    }

    public static func throwPageNumberException(eventType: String) {
        let message = "Page numbers should not be less than 1"
        let exception = IllegalArgumentException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalArgumentException", stackTrace: exception)
    }

    public static func throwItemQuantityException(eventType: String) {
        let message = "Item Quantity should be 0 or greater than 0"
        let exception = IllegalArgumentException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalArgumentException", stackTrace: exception)
    }

    public static func throwCurrencyNotSameException(eventType: String, valueName: String) {
        let message = "Currency for \(valueName) and item(s) should be same."
        let exception = IllegalArgumentException(message)
        callExceptionAPI(title: message, eventType: eventType, exceptionType: "IllegalArgumentException", stackTrace: exception)
    }

    public static func throwInvalidNudgeException(message: String, nudgeObject: String) {
        let exception = IllegalArgumentException(message)

        let exceptionDataObject = ExceptionDataObject(
            title: message,
            eventType: CoreEventType.NudgeResponse.rawValue,
            exceptionType: "IllegalArgumentException",
            exceptionSource: "SDK",
            stackTrace: "Nudge Object:\n\(nudgeObject) \n\nException:\n\(exception)",
            ts: Date().convertMillisToTimeString()
        )

        ExceptionAPIHandler().exceptionTrackAPI(
            exceptionObject: exceptionDataObject,
            updateImmediately: false
        )
    }

    public static func throwInvalidNetworkException(message: String, speed: Int) {
        let exception = IllegalArgumentException(message)

        let exceptionDataObject = ExceptionDataObject(
            title: message,
            eventType: CoreEventType.App.rawValue,
            exceptionType: "IllegalArgumentException",
            exceptionSource: "SDK",
            stackTrace: "Value: \(speed) \n\nException:\n\(exception)",
            ts: Date().convertMillisToTimeString()
        )

        ExceptionAPIHandler().exceptionTrackAPI(
            exceptionObject: exceptionDataObject,
            updateImmediately: false
        )
    }

    public static func throwInternalCrashException(eventType: String, message: String, exception: Error) {
        let exceptionDataObject = ExceptionDataObject(
            title: message,
            eventType: eventType,
            exceptionType: "RuntimeException",
            exceptionSource: "SDK",
            stackTrace: exception.localizedDescription,
            ts: Date().convertMillisToTimeString()
        )

        ExceptionAPIHandler().exceptionTrackAPI(
            exceptionObject: exceptionDataObject,
            updateImmediately: false
        )
    }

    // Other exception throwing functions...

    private static func callExceptionAPI(
        title: String,
        eventType: String,
        exceptionType: String,
        stackTrace: ExceptionError
    ) {
        if #available(iOS 13.0, *) {
            let exceptionDataObject = ExceptionDataObject(
                title: title,
                eventType: eventType,
                exceptionType: exceptionType,
                exceptionSource: "SDK",
                stackTrace: stackTrace.localizedDescription,
                ts: Date().convertMillisToTimeString()
            )
            
            ExceptionAPIHandler().exceptionTrackAPI(exceptionObject: exceptionDataObject, updateImmediately: false)
            
            if CoreConstants.shared.isDebugMode, CoreConstants.shared.isAppDebuggable {
                // Handle debug mode throwing exception
                fatalError(stackTrace.localizedDescription)
            }
        }
    }
}
