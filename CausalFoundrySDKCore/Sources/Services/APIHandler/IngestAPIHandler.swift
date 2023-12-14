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
    
    private let reachability = try! Reachability()

    func ingestTrackAPI<T: Codable>(contentBlock: String,
                                    eventType: String,
                                    trackProperties: T,
                                    updateImmediately: Bool,
                                    eventTime _: Int64 = 0)
    {
        guard !CoreConstants.shared.pauseSDK else { return }
        
        let isInternetAvailable = reachability.connection == .wifi || reachability.connection == .cellular
        let eventObject = EventDataObject(block: contentBlock, ol: isInternetAvailable, ts: Date(), type: eventType, props: trackProperties)

        if updateImmediately && isInternetAvailable {
            updateEventTrack(eventArray: [eventObject]) { [weak self] success in
                if !success {
                    self?.storeEventTrack(eventObject: eventObject)
                }
            }
        } else {
            storeEventTrack(eventObject: eventObject)
        }
    }

    func updateEventTrack(eventArray: [EventDataObject], callback: @escaping (Bool) -> Void) {

        guard let userID = CoreConstants.shared.userId, !userID.isEmpty else {
            callback(false)
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

        var showDelayNotification = true
        
        if NotificationConstants.shared.INGEST_NOTIFICATION_ENABLED {
            DispatchQueue.main.asyncAfter(deadline: .now() + NotificationConstants.shared.INGEST_NOTIFICATION_INTERVAL_TIME) { [weak self] in
                if showDelayNotification {
                    self?.showNotification()
                }
            }
        }
        
        let url = URL(string: APIConstants.trackEvent)!
        BackgroundRequestController.shared.request(url: url, httpMethod: .post, params: dictionary) { result in
            showDelayNotification = false
            switch result {
            case .success:
                callback(true)
            case .failure:
                callback(false)
            }
        }
    }

    private func storeEventTrack(eventObject: EventDataObject) {
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

    private func callCurrencyApi(fromCurrency: String) -> Float {
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
    private func showNotification() {
        /*
        guard let topViewController = UIApplication.shared.rootViewController else { return }
        let alert = UIAlertController(title: NotificationConstants.shared.INGEST_NOTIFICATION_TITLE, message: NotificationConstants.shared.INGEST_NOTIFICATION_DESCRIPTION, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        topViewController.present(alert, animated: true, completion: nil)
        */
    }
}

extension UIApplication {
    
    var rootViewController: UIViewController? {
        windows.filter({ $0.isKeyWindow }).first?.rootViewController
    }
}
