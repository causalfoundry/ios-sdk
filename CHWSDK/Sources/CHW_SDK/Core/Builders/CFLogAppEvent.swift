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
    
    public class Builder {
        
        private var action:String?
        private var meta:Any?
        private var startTimeValue:Int = 0
        private var eventTimeValue:Int64 = 0
        private var update_immediately:Bool = CoreConstants.shared.updateImmediately
        
        public init() {
            
        }
        /**
         * setAppEvent is for the providing the current state of the app which is open, close,
         * background and resume, you can provide the value by using the enum given in the SDK or
         * by passing a string reference, below is for providing the app event using string. In
         * case of string, the values should be same to what is defined in the enum to log the
         * event correctly or else it will be discarded.
         */
        
        public func setAppEvent(appAction: AppAction) {
            self.action = appAction.rawValue
        }
        
        /**
         * setEventTime is for the providing the start and end time for the app to measure
         * app start time and session logs
         */
        
        public func setEventTime(event_time:Int64) {
            self.eventTimeValue = event_time
        }
        /**
         * setStartTime is for the providing the latency time in terms of rendering the first
         * page on the screen since the app tap is pressed, difference in ms
         */
        
        public func setStartTime(start_time :Int) {
            self.startTimeValue = start_time
        }
        
        /**
         * You can pass any type of value in setMeta. It is for developer and partners to log
         * additional information with the log that they find would be helpful for logging and
         * providing more context to the log. Default value for the meta is null.
         */
        
        public func setMeta(meta:Any?)  {
            self.meta = meta
        }
        
        /**
         * updateImmediately is responsible for updating the values ot the backend immediately.
         * By default this is set to false or whatever the developer has set in the SDK
         * initialisation block. This differs the time for which the logs will be logged, if true,
         * the SDK will log the content instantly and if false it will wait till the end of user
         * session which is whenever the app goes into background.
         */
        
        
        public func updateImmediately(update_immediately:Bool)  {
            self.update_immediately = update_immediately
        }
        
        
        /**
         * build will validate all of the values provided and if passes will call the track
         * function and queue the events based on it's updateImmediately value and also on the
         * user's network resources.
         */
        
        
        public func build() {
            while(self.action == nil ) {
                ExceptionManager.shared.throwInitException(eventType: "CFLog")
                fatalError("action not found")
            }
            
            let appObject = AppObject(action:self.action!, startTime:"\(self.startTimeValue)", meta:(meta as? String) ?? "" )
            
            if CoreConstants.shared.application != nil {
                IngestAPIHandler.shared.ingestTrackAPI(contentBlock: CoreConstants.shared.contentBlockName,eventType: CoreEventType.app.rawValue, trackProperties:appObject, updateImmediately: update_immediately,eventTime: eventTimeValue)
            }
        }
    }
    
}

