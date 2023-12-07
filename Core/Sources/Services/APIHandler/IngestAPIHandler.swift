//
//  IngestAPIHandler.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Combine
import Foundation
import UIKit

public class IngestAPIHandler: NSObject {

    static let shared = IngestAPIHandler()
    
    let reachability = try! Reachability()

    func ingestTrackAPI<T: Codable>(contentBlock: String,
                                    eventType: String,
                                    trackProperties: T,
                                    updateImmediately: Bool,
                                    eventTime _: Int64 = 0)
    {
        if !CoreConstants.shared.pauseSDK {
            reachability.stopNotifier()

            let isInternetAvailable: Bool = (reachability.connection == .wifi || reachability.connection == .cellular) ? true : false
            let eventObject = EventDataObject(block: contentBlock, ol: isInternetAvailable, ts: Date(), type: eventType, props: trackProperties)

            if updateImmediately {
                updateEventTrack(eventArray: [eventObject]) { [weak self] success in
                    if !success {
                        self?.storeEventTrack(eventObject: eventObject)
                    }
                }
            } else {
                storeEventTrack(eventObject: eventObject)
            }
        }
    }

    func updateEventTrack(eventArray: [EventDataObject], callback: @escaping (Bool) -> Void) {
        var userID: String = CoreConstants.shared.userId

        if !CoreConstants.shared.isAnonymousUserAllowed {
            userID = ""
        }
        guard !userID.isEmpty else {
            callback(true)
            return
        }

        let mainBody = MainBody(sID: "\(userID)_\(CoreConstants.shared.sessionStartTime)_\(CoreConstants.shared.sessionEndTime)",
                                uID: userID, appInfo: CoreConstants.shared.appInfoObject!,
                                dInfo: CoreConstants.shared.deviceObject!,
                                dn: Int(NetworkMonitor.shared.downloadSpeed),
                                sdk: CoreConstants.shared.SDKVersion,
                                up: Int(NetworkMonitor.shared.uploadSpeed),
                                data: eventArray)

        let dictionary = mainBody.dictionary ?? [:]

        print(dictionary.prettyJSON)
        // Show notification if tasks takes more then 10 seconds to complete and if allowed

        DispatchQueue.main.async {
            if NotificationConstants.shared.INGEST_NOTIFICATION_ENABLED {
                self.showNotification()
            }
        }
        
        let url = URL(string: APIConstants.trackEvent)!
        BackgroundRequestController.shared.request(url: url, httpMethod: .post, params: dictionary) { result in
            switch result {
            case .success:
                callback(true)
            case .failure:
                callback(false)
            }
        }
    }

    func storeEventTrack(eventObject: EventDataObject) {
        var prevEvent = MMKVHelper.shared.readInjectEvents()
        prevEvent.append(eventObject)
        MMKVHelper.shared.writeEvents(eventsArray: prevEvent)
    }

    func getUSDRate(fromCurrency: String) -> Float {
        let currencyObject: CurrencyMainObject? = MMKVHelper.shared.readCurrencyObject()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let isAgainRate = CoreConstants.shared.isAgainRate
        CoreConstants.shared.isAgainRate = true
        
        if let currencyObject = currencyObject,
           currencyObject.fromCurrency == fromCurrency,
           let toCurrencyObject = currencyObject.toCurrencyObject,
           toCurrencyObject.date == dateFormatter.string(from: Date()) || isAgainRate
        {
           return toCurrencyObject.usd
        } else {
           return callCurrencyApi(fromCurrency: fromCurrency)
        }
    }

    func callCurrencyApi(fromCurrency: String) -> Float {
        let currencyObject = CurrencyMainObject(
            fromCurrency: fromCurrency,
            toCurrencyObject: CurrencyObject(
                date: "",
                usd: CoreConstants.shared.getCurrencyFromLocalStorage(fromCurrency: fromCurrency)
            )
        )
        let usdRate = currencyObject.toCurrencyObject?.usd ?? 0.0
        return usdRate
    }
}

extension IngestAPIHandler: UNUserNotificationCenterDelegate {
    private func showNotification() {}
}
