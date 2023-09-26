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
    
    func ingestTrackAPI(contentBlock: String,
                        eventType: String,
                        trackProperties: Any,
                        updateImmediately: Bool,
                        eventTime: Int64 = 0) {
        
        if (!CoreConstants.shared.pauseSDK) {
            _ =  CoreConstants.shared.application
            var timezone = Date().convertMillisToTimeString(eventTime:1000)
            var isInternetAvailable:Bool = false
            
            var cancellables = Set<AnyCancellable>()
            
            let combineNetworkMonitor = NetworkMonitor.shared
            combineNetworkMonitor.startMonitoring()
            combineNetworkMonitor.connectivityStatus
                .removeDuplicates()
                .sink { [weak self] status in
                    guard self != nil else { return }
                    isInternetAvailable = (status == .connected) ?  true :  false
                    var eventOnject = EventDataObject(block:contentBlock , props: trackProperties as! Props, type: eventType, ol: isInternetAvailable, ts:"\(eventTime)")
                    
                    if(updateImmediately) {
                        self?.updateEvenrTrack(eventArray:[eventOnject])
                    }else {
                        //storeEventTrack ()
                    }
                }
                .store(in: &cancellables)
        }
        
        
    }
    
    // Update Track Event
    func updateEvenrTrack(eventArray:[EventDataObject]) {
        var appObject = CoreConstants.shared.application
        var networkObj = NetworkMonitor.shared
        var userID:String = ""
        
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
                try APIManager.shared.getAPIDetails(url: APIConstants.trackEvent, params: mainBody.jsonString() ?? "", isPost: true, headers:nil) { result in
                    
                }
            } catch {
                
            }
            
        }
        
        
    }
    
    
}


extension IngestAPIHandler:UNUserNotificationCenterDelegate {
    private func ShowNotification (application:UIApplication) {
        
        
    }
}
