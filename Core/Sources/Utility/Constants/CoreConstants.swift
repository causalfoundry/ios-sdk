//
//  File.swift
//  
//
//  Created by khushbu on 11/09/23.
//

import Foundation
import UIKit


class CoreConstants {
    static let shared = CoreConstants()
    
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
    

    var userIdKey: String = "userIdKey"
    
    var isAppDebuggable: Bool = true
    
    var logoutEvent: Bool = false

}
