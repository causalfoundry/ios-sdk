//
//  CFLogAppEvent.swift
//
//
//  Created by khushbu on 14/09/23.
//

import Foundation

/**
 * CfLogAppEvent is required to log events related app lifecycle. App events are auto triggered
 * based on the implementation and can listen to 4 app states:
 * App Open
 * App in Background
 * App Resume
 * App Closed/Killed
 */

public class CFLogAppEvent {
    var action: String?
    var meta: Any?
    var startTimeValue: Int = 0
    var eventTimeValue: Int64 = 0
    var update_immediately: Bool = CoreConstants.shared.updateImmediately

    init(action: String? = nil, meta: Any? = nil, startTimeValue: Int, eventTimeValue: Int64, update_immediately: Bool) {
        self.action = action
        self.meta = meta
        self.startTimeValue = startTimeValue
        self.eventTimeValue = eventTimeValue
        self.update_immediately = update_immediately
    }
}

public class CFLogAppEventBuilder {
    var action: String?
    var meta: Any?
    var startTimeValue: Int = 0
    var eventTimeValue: Int64 = 0
    var update_immediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setAppEvent is for the providing the current state of the app which is open, close,
     * background and resume, you can provide the value by using the enum given in the SDK or
     * by passing a string reference, below is for providing the app event using string. In
     * case of string, the values should be same to what is defined in the enum to log the
     * event correctly or else it will be discarded.
     */
    @discardableResult
    public func setAppEvent(appAction: AppAction) -> CFLogAppEventBuilder {
        action = appAction.rawValue
        return self
    }

    @discardableResult
    public func setAppEvent(appAction: String) -> CFLogAppEventBuilder {
        action = appAction
        return self
    }

    /**
     * setEventTime is for the providing the start and end time for the app to measure
     * app start time and session logs
     */
    @discardableResult
    public func setEventTime(event_time: Int64) -> CFLogAppEventBuilder {
        eventTimeValue = event_time
        return self
    }

    /**
     * setStartTime is for the providing the latency time in terms of rendering the first
     * page on the screen since the app tap is pressed, difference in ms
     */
    @discardableResult
    public func setStartTime(start_time: Int) -> CFLogAppEventBuilder {
        startTimeValue = start_time
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CFLogAppEventBuilder {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values ot the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialisation block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait till the end of user
     * session which is whenever the app goes into background.
     */

    @discardableResult
    public func updateImmediately(update_immediately: Bool) -> CFLogAppEventBuilder {
        self.update_immediately = update_immediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        while action == nil {
            ExceptionManager.throwInitException(eventType: "CFLog")
            fatalError("action not found")
        }

        let appObject = AppObject(action: action!, startTime: startTimeValue, meta: (meta as? String) ?? "")

        IngestAPIHandler.shared.ingestTrackAPI(contentBlock: CoreConstants.shared.contentBlockName, eventType: CoreEventType.app.rawValue, trackProperties: appObject, updateImmediately: update_immediately, eventTime: eventTimeValue)
    }
}
