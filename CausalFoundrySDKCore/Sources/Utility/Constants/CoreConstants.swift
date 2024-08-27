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

    public let devUrl = "https://api-dev.causalfoundry.ai/v1/"
    public let prodUrl = "https://api.causalfoundry.ai/v1/"
    public private(set) var apiUrl: String

    
    
    private init() {
            // Initialize apiUrl with the default prodUrl
            self.apiUrl = prodUrl
        }
    public func setApiUrl(to url: String) {
            apiUrl = url
        }
    
    public var userId: String? {
        get {
            var id = MMKVHelper.shared.fetchUserID()
            if id?.isEmpty == true {
                id = UIDevice.current.identifierForVendor?.uuidString
            }
            return id
        }
        set { MMKVHelper.shared.writeUser(user: newValue) }
    }
    
    public var applicationContext: UIApplication? = nil
    var sdkKey: String = ""
    var isDebugMode: Bool = true
    var allowAutoPageTrack: Bool = true
    var isAnonymousUserAllowed: Bool = false
    var contentBlock: ContentBlock = .Core
    var contentBlockName: String {
        return contentBlock.rawValue
    }

    var SDKVersion: String = "ios/1.0.3"

    public var updateImmediately: Bool = false

    public var pauseSDK: Bool = false
    public var autoShowInAppNudge: Bool = true
    var sessionStartTime: Int64 = 0
    var sessionEndTime: Int64 = 0

    var deviceObject: DInfo?
    var appInfoObject: AppInfo?
    public var previousSearchId: String = ""

    public var userIdKey: String = "userIdKey"

    public var isAppDebuggable: Bool = true

    public var logoutEvent: Bool = false

    public var isAppOpen: Bool = false
    public var isAppPaused: Bool = false

    public var impressionItemsList = [String]()

    public var isAgainRate: Bool = false

    public func enumContains<T: EnumComposable>(_: T.Type, name: String?) -> Bool where T.RawValue == String {
        if(name == nil || name!.isEmpty){
            return false
        }
        return T.allCases.contains { $0.rawValue == name }
    }
}

public protocol EnumComposable: Codable, RawRepresentable, CaseIterable {}

extension CoreConstants {
    func isSearchItemModelObjectValid(itemValue: SearchItemModel, eventType: CoreEventType) {
        
        print("SearchItemModel: \(itemValue)")
        
        let eventName = eventType.rawValue

        guard !itemValue.id!.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_id")
            return
        }

        guard !itemValue.type!.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_type")
            return
        }

        if !CoreConstants.shared.enumContains(SearchItemType.self, name: itemValue.type!) {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
            return
        }
        
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
