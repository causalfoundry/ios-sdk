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
    
    enum Result<T, E: Error> {
        case success(T)
        case failure(E)
    }
    
    
    
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
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
            let eventObject = EventDataObject(content_block:contentBlock , online: isInternetAvailable, ts: "\(timezone)", event_type: eventType, event_properties: (trackProperties as! Encodable))
                    
                    if(updateImmediately) {
                        self.updateEventTrack(eventArray:[eventObject] ) { result in
                            print(result)
                        }
                    }else {
                        self.storeEventTrack(eventObject:eventObject)
                    }
                }
        }
        
    
    
    // GET USD Rate
   
            
    
    // Update Track Event
    func updateEventTrack(eventArray:[EventDataObject], callback: @escaping (Bool) -> Void) {
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
                       callback(true)
                    
                })
            }catch(let error){
                    callback(false)
            }
            
        }
        
        
    }
    
    
    func storeEventTrack (eventObject:EventDataObject) {
        var prevEvent = CoreDataHelper.shared.readEvents()
        prevEvent.append(eventObject)
        CoreDataHelper.shared.writeEvents(eventsArray:prevEvent)
    }
    
    func storeEventTracks(eventObjects:[EventDataObject]) {
        
    }
    
    public func getUSDRate(fromCurrency: String, callback: @escaping (Float) -> Float) {
        let currencyObject: CurrencyMainObject? = CoreDataHelper.shared.readCurrencyObject()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let currencyObject = currencyObject,
            currencyObject.fromCurrency == fromCurrency,
            let toCurrencyObject = currencyObject.toCurrencyObject,
           toCurrencyObject.date == dateFormatter.string(from: Date()) || CoreConstants.shared.isAgainRate {
                _ = callback(toCurrencyObject.usd)
        } else {
           _ =  callCurrencyApi(fromCurrency: fromCurrency)
           
        }
        
        CoreConstants.shared.isAgainRate = true
    }
 

    public func callCurrencyApi(fromCurrency: String)  -> Float {
       let currencyObject = CurrencyMainObject(
                    fromCurrency: fromCurrency,
                    toCurrencyObject: CurrencyObject(
                        date: "",
                        usd: CoreConstants.shared.getCurrencyFromLocalStorage(fromCurrency:fromCurrency )
                ))
                let usdRate = currencyObject.toCurrencyObject?.usd ?? 0.0
                return usdRate
            }
        }
extension IngestAPIHandler:UNUserNotificationCenterDelegate {
    private func ShowNotification (application:UIApplication) {
        
        
    }
}
