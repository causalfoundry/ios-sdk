// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

public class CFLog : NSObject {
    
    public class Builder: NSObject {
        private var application: UIApplication?
        private var applicationState: UIApplication.State?
        private var showInAppBudge:Bool = true
        private var updateImmediately :Bool = true
        private var pauseSDK : Bool =  false
        
        /**
         * Passing the application Object to SDK for initialising listeners
         */
       public init(application: UIApplication) {
            self.application = application
        }
        /**
         * Passing the lifecycle event variable to SDK to log app open and resume events
         * automatically and manage app lifecycle components required by SDK to operate
         */
        
        public func setLifecycleEvent(event: UIApplication.State ) {
            self.applicationState = event
            
        }
        
        /**
         * Using this will set the SDK on pause that it will not log any event and will not listen
         * for the nudges but FCM based nudges will still work base on the device token status.
         * DEFAULT value is FALSE
         */
        public func setPauseSDK(pauseSDK: Bool){
            self.pauseSDK = pauseSDK
        }
        
        /**
         * Using this will set the SDK key for the successful initialisation. You can either set
         * the API key from info.plist or using this endpoint. SDK key can be obtained from
         * the CF platform.
         */
        public func setSdkKey(sdkKey: String){
            CoreConstants.shared.sdkKey = "Bearer \(sdkKey)"
        }
        
        /**
         * Using this will disable the SDK debug mode. Using this will stop the SDK from throwing
         * any exception which can result in app crash. By default it is recommended to not use
         * this as then you can validate all the values are correct or not. Debug mode is enabled
         * by default.
         */
        
        public func disableDebugMode() {
            CoreConstants.shared.isDebugMode = false
        }
        
        /**
         * Using this will disable the SDK Auto Page track and you have to include the page
         * event at your own based on your navigation graph pr page/activity change logic.
         * Auto Page Track mode is enabled by default.
         */
        public  func disableAutoPageTrack() {
            CoreConstants.shared.allowAutoPageTrack = false
        }
        /**
         * SDK will not log events until the user is logged in, and once logged in, it will
         * associate those events to the logged in user id. Default is set to false. enabling
         * this flag, will send the events data regardless of the login state of the user.
         * In such cases, the device Id will be used as the userId
         */
        public func allowAnonymousUsers() {
            CoreConstants.shared.isAnonymousUserAllowed = true
        }
        
        /**
         * setAppLevelContentBlock is used to specify the type of module the app is used for.
         * content block can be in any modules i.e. core, e-commerce, e-learning, ...
         * SDK provides enum ContentBlock to log the module, you can also use string function as
         * well in order to log the content block. Below is the function for the usage of enum type
         * function.
         *
         * NOTE that this will only update for the values in the core block and not for the rest.
         */
        public func setAppLevelContentBlock(contentBlock: ContentBlock){
            CoreConstants.shared.contentBlockName = contentBlock.rawValue
        }
        /**
         * setAppLevelContentBlock is used to specify the type of module the app is used for.
         * content block can be in any modules i.e. core, e-commerce, e-learning, ...
         * SDK provides enum ContentBlock to log the module, you can also use string function as
         * well in order to log the content block. Below is the function for the usage of string type
         * function. Remember to note that you need to use the same enum types as provided by the
         * enums or else the events will be discarded.
         *
         * NOTE that this will only update for the values in the core block and not for the rest.
//         */
//                public func setAppLevelxContentBlock(content_block: String) {
//                    if (ContentBlock.RawValue == content_block ) {
//                        CoreConstants.contentBlockName = content_block
//                    } else {
//                        ExceptionManager.throwEnumException("CFLog", ContentBlock::class.java.simpleName)
//                    }
//                }
        
        public func setAutoShowInAppNudge(showInAppNudge: Bool) {
            self.showInAppBudge = showInAppNudge
        }
        
        /**
         * Using this will set the update immediately level for all of the events to be either
         * fired immediately ot after the end of the session. You can also set the
         * updateImmediately for each event.
         * DEFAULT value is FALSE
         */
        public func updateImmediately(updateImmediately: Bool) {
            self.updateImmediately = updateImmediately
        }
        
        /**
         * Set the properties for the notification elements, for push notifications for
         * ingest workflow. By default the SDK will show the notification if the API call
         * takes more then 10 seconds as recommended by google. You can use the below provided
         * properties to update the values as per your app configurations.
         *
         * `setIngestNotificationTitle` is for setting your own custom title for the
         * notification, by default SDK shows `Backing up events` in LOCALE EN
         */
        public func setIngestNotificationTitle(notificationTitle: String)  { NotificationConstants.shared.INGEST_NOTIFICATION_TITLE = notificationTitle
        }
        
        /**
         * `setIngestNotificationDescription` is for setting your own custom description for the
         * notification, by default SDK shows `Please wait while we are backing
         * up events.` in LOCALE EN
         */
        public func setIngestNotificationDescription(notificationDescription: String)   {
            NotificationConstants.shared.INGEST_NOTIFICATION_DESCRIPTION = notificationDescription
        }
        
        /**
         * `setIngestNotificationEnabled` is for setting the preference to show ingest
         * notification, if you want to show the notification or not. By default the SDK
         * shows the notification and this is set as true, but the SDK only shows the
         * notification if the API takes more then 10 seconds as per recommended by google.
         * You can change that to false based on your app configuration but it is not recommended.
         */
        public func setIngestNotificationEnabled(isNotificationEnabled: Bool) {
            NotificationConstants.shared.INGEST_NOTIFICATION_ENABLED = isNotificationEnabled
        }
        
        /**
         * `updateIngestNotificationShowInterval` is for setting the time interval the SDK
         * will wait for the API to complete. By default this is set to 10 seconds as
         * recommended by google but you can change that based on your app configuration.
         * However it is not recommended to do so.
         */
        public  func updateIngestNotificationShowInterval(notificationShowInterval: Int64){
            NotificationConstants.shared.INGEST_NOTIFICATION_INTERVAL_TIME = notificationShowInterval
        }
        
        /**
         * `updateInAppMessageInitialDelay` is for setting the time interval the SDK
         * will wait before showing the In App message after the app is opened. By default,
         * the SDK waits for 5 seconds (5000L). However, you can pass a value as per your app's
         * configuration.
         */
        public func updateInAppMessageInitialDelay(initialDelayInMillis: Int64) {
            NotificationConstants.shared.IN_APP_MESSAGE_INITIAL_DELAY_IN_MILLIS = initialDelayInMillis
        }
        
        /**
         * Using this will validate the endpoints provided and initialise the SDK
         */
        public func build() {
            while(self.application == nil ) {
                ExceptionManager.shared.throwInitException(eventType: "CFLog")
                fatalError("Application object not found")
            }
            while(self.applicationState == nil ) {
                ExceptionManager.shared.throwInitException(eventType: "CFLog")
                fatalError("Application state object not found")
            }
            CFSetup().initalize(application: self.application!, event: self.applicationState!, pauseSDK: pauseSDK, autoShowInAppNudge: showInAppBudge, updateImmediately: updateImmediately)
            }
        }
    }