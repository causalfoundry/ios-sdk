//
//  CoreConstants.swift
//
//
//  Created by khushbu on 11/09/23.
//

import Foundation
import UIKit


public class CoreConstants {
    public static let shared = CoreConstants()
    
    let devUrl = "https://api-dev.causalfoundry.ai/v1/"
    let prodUrl = "https://api.causalfoundry.ai/v1/"
    
    
    var userId: String = ""
    var sdkKey: String = ""
    var isDebugMode: Bool = true
    var allowAutoPageTrack:Bool = true
    var isAnonymousUserAllowed:Bool = false
    var contentBlockName:String = ""
    
    
    //private var SDKString: String = "/0.2.2"
    var SDKVersion: String = "ios\(0.2)"
    
    var updateImmediately: Bool = false
    
    var pauseSDK: Bool = false
    var autoShowInAppNudge: Bool = true
    var application: UIApplication? = nil
    var sessionStartTime: Int64 = 0
    var sessionEndTime: Int64 = 0
    
    var deviceObject: DInfo?
    var appInfoObject:AppInfo?
    var previousSearchId:String? = ""
    
    var userIdKey: String = "userIdKey"
    
    var isAppDebuggable: Bool = true
    
    var logoutEvent: Bool = false
    
    
   var impressionItemsList = [String]()
    
    func enumContains<T: EnumComposable>(_ type: T.Type, name: String) -> Bool where T.RawValue == String {
        return T.allCases.contains{ $0.rawValue == name }
    }
}

protocol EnumComposable :RawRepresentable,CaseIterable{
    
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
    
    func getUserTimeZone() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Z"
        return dateFormatter.string(from: Date())
    }

}
