//
//  CoreConstants.swift
//
//
//  Created by khushbu on 11/09/23.
//

import Foundation
import UIKit
import CasualFoundryResourcePackage


public class CoreConstants {
    public static let shared = CoreConstants()
    
    let devUrl = "https://api-dev.causalfoundry.ai/v1/"
    let prodUrl = "https://api.causalfoundry.ai/v1/"
    
    
    public var userId: String = ""
    var sdkKey: String = ""
    var isDebugMode: Bool = true
    var allowAutoPageTrack:Bool = true
    var isAnonymousUserAllowed:Bool = false
    var contentBlockName:String = ""
    
    
    //private var SDKString: String = "/0.2.2"
    var SDKVersion: String = "ios\(0.2)"
    
    public var updateImmediately: Bool = false
    
    public var pauseSDK: Bool = false
    public var autoShowInAppNudge: Bool = true
    public  var application: UIApplication? = nil
    var sessionStartTime: Int64 = 0
    var sessionEndTime: Int64 = 0
    
    var deviceObject: DInfo?
    var appInfoObject:AppInfo?
    public var previousSearchId:String? = ""
    
    public  var userIdKey: String = "userIdKey"
    
    public var isAppDebuggable: Bool = true
    
    public var logoutEvent: Bool = false
    
    public var isAppOpen:Bool = false
    public var isAppPaused:Bool = false
    
    
    public var impressionItemsList = [String]()
    
    public var isAgainRate: Bool = false
    
    public func enumContains<T: EnumComposable>(_ type: T.Type, name: String) -> Bool where T.RawValue == String {
        return T.allCases.contains{ $0.rawValue == name }
    }
}

public protocol EnumComposable :RawRepresentable,CaseIterable{
    
}



extension CoreConstants {
    
    func isSearchItemModelObjectValid(itemValue: SearchItemModel, eventType: CoreEventType) {
        let eventName = eventType.rawValue
        
        guard !itemValue.id!.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_id")
            return
        }
        
        guard !itemValue.type!.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_type")
            return
        }
        
        guard let _ = SearchItemType(rawValue: itemValue.type!) else {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
            return
        }
    }
    
    
    public func getCurrencyFromLocalStorage(fromCurrency: String) -> Float {
        do {
            if let sharedBundle = Bundle.module.url(forResource: "usd_rates", withExtension: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath:sharedBundle.path))
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let rate = json?[fromCurrency.lowercased()] as? Float {
                        return 1.0 / rate
                    }
                    
                
            }
        }
        catch {
            // Handle the error, e.g., print or log it
            print("Error reading currency rates: \(error)")
        }
        
        return 1.0 // Default rate if not found
    }
    
    
    
    
    func getUserTimeZone() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Z"
        return dateFormatter.string(from: Date())
    }
    
    public func checkIfNull(_ inputValue: String?) -> String {
        if let value = inputValue, !value.isEmpty {
            return value
        }
        return ""
    }
    
    
}
