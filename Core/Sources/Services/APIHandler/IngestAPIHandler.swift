//
//  IngestAPIHandler.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import Combine
import UIKit


public class IngestAPIHandler:NSObject {
    
    static let shared = IngestAPIHandler()
    let reachability = try! Reachability()
    
    func ingestTrackAPI(contentBlock: String,
                        eventType: String,
                        trackProperties: Any,
                        updateImmediately: Bool,
                        eventTime: Int64 = 0) {
        
        if (!CoreConstants.shared.pauseSDK) {
            _ =  CoreConstants.shared.application
            
            let timezone = Date().convertMillisToTimeString()
            
            reachability.stopNotifier()
            let isInternetAvailable :Bool = (reachability.connection == .wifi || reachability.connection == .cellular) ? true :  false
//            
//            let eventObject = EventDataObject(block:contentBlock ,
//                                              props: trackProperties,
//                                              type: eventType,
//                                              ol: isInternetAvailable,
//                                              ts:"\(timezone)")
            
            let eventObject = EventDataObject(content_block:contentBlock , online: isInternetAvailable, ts: "\(timezone)", event_type: eventType, event_properties: (trackProperties as! Encodable))
                    
                    if(updateImmediately) {
                        self.updateEvenrTrack(eventArray:[eventObject])
                    }else {
                        self.storeEventTrack ()
                    }
                }
        }
        
    
    
    // GET USD Rate
   
            
    
    // Update Track Event
    func updateEvenrTrack(eventArray:[EventDataObject]) {
        var userID:String = CoreConstants.shared.userId
        
        if (!CoreConstants.shared.isAnonymousUserAllowed) {
            userID = ""
        }
        if userID != "" {
            let mainBody = MainBody(sID: "\(userID)_\(CoreConstants.shared.sessionStartTime)_\(CoreConstants.shared.sessionEndTime)", uID: userID, appInfo:CoreConstants.shared.appInfoObject! , dInfo: CoreConstants.shared.deviceObject!, dn: Int(NetworkMonitor.shared.downloadSpeed), sdk:  CoreConstants.shared.SDKVersion, up: Int(NetworkMonitor.shared.uploadSpeed), data: eventArray)
            
            
            print(mainBody.dictionary)
            // Show notification if tasks takes more then 10 seconds to complete and if allowed
            
            DispatchQueue.main.async {
                if (NotificationConstants.shared.INGEST_NOTIFICATION_ENABLED) {
                    self.ShowNotification(application: CoreConstants.shared.application!)
                }
            }
            do {
                try APIManager.shared.getAPIDetails(url:APIConstants.trackEvent , params: mainBody.dictionary, "POST", headers:nil, completion:{ (result) in
                   
                    
                })
            } catch {
                
            }
            
        }
        
        
    }
    
    
    func storeEventTrack () {
        
    }
    
}


extension IngestAPIHandler:UNUserNotificationCenterDelegate {
    private func ShowNotification (application:UIApplication) {
        
        
    }
}
