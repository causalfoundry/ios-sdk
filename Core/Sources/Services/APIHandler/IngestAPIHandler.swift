//
//  IngestAPIHandler.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import Combine
import UIKit

class IngestAPIHandler:NSObject {
    
    static let shared = IngestAPIHandler()
    let reachability = try! Reachability()
    
    func ingestTrackAPI(contentBlock: String,
                        eventType: String,
                        trackProperties: Any,
                        updateImmediately: Bool,
                        eventTime: Int64 = 0) {
        
        if (!CoreConstants.shared.pauseSDK) {
            _ =  CoreConstants.shared.application
            
            let timezone = Date().convertMillisToTimeString(eventTime:1000)
            
            reachability.stopNotifier()
            let isInternetAvailable :Bool = (reachability.connection == .wifi || reachability.connection == .cellular) ? true :  false
            
            let eventObject = EventDataObject(block:contentBlock ,
                                              props: trackProperties as! AppObject,
                                              type: eventType,
                                              ol: isInternetAvailable,
                                              ts:"\(timezone)")
                    
                    if(updateImmediately) {
                        self.updateEvenrTrack(eventArray:[eventObject])
                    }else {
                        self.storeEventTrack ()
                    }
                }
               
        }
        
    
    // Update Track Event
    func updateEvenrTrack(eventArray:[EventDataObject]) {
        var userID:String = "1"
        
        if (!CoreConstants.shared.isAnonymousUserAllowed) {
            userID = ""
        }
        if userID != "" {
            let mainBody = MainBody(sID: "\(userID)_\(CoreConstants.shared.sessionStartTime)_\(CoreConstants.shared.sessionEndTime)", uID: userID, appInfo:CoreConstants.shared.appInfoObject! , dInfo: CoreConstants.shared.deviceObject!, dn: Int(NetworkMonitor.shared.downloadSpeed), sdk:  CoreConstants.shared.SDKVersion, up: Int(NetworkMonitor.shared.uploadSpeed), data: eventArray)
            
            // Show notification if tasks takes more then 10 seconds to complete and if allowed
            
            DispatchQueue.main.async {
                if (NotificationConstants.shared.INGEST_NOTIFICATION_ENABLED) {
                    self.ShowNotification(application: CoreConstants.shared.application!)
                }
            }
            do {
                try APIManager.shared.getAPIDetails(url:APIConstants.trackEvent , params: mainBody.dictionary, "POST", headers:nil, completion:{ (result) in
                    
                    print(result)
                    
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
