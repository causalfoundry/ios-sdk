//
//  CFSetup.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit

import FileProvider


public class CFSetup:NSObject, IngestProtocol {
   
    
    public var ingestApiHandler = IngestAPIHandler()
    public var catalogAPIHandler = CatalogAPIHandler()
    private var userId: String = ""
    
    
    private func setup()   {
        verifyAccessToken()
        CoreConstants.shared.deviceObject = DInfo(brand:"Apple" , id: UIDevice.current.identifierForVendor!.uuidString, model: UIDevice.modelName, os: "iOS", osVer:"\(UIDevice.current.systemVersion)")
        
        CoreConstants.shared.appInfoObject = getApplicationInfo()
        
        
        //Change implementation
        
        CoreConstants.shared.sessionStartTime = Int64(Date().timeIntervalSince1970 * 1000)
        CoreConstants.shared.sessionEndTime = Int64(Date().timeIntervalSince1970 * 1000)
        
        
        userId = CoreDataHelper.shared.fetchUserID()
        if (!userId.isNilOREmpty()) {
            scheduleBackendNudgeListener()
        }
    }
    
    func initalize(event: UIApplication.State, pauseSDK: Bool, autoShowInAppNudge: Bool, updateImmediately: Bool) {
        CoreConstants.shared.isAppDebuggable = true
        CoreConstants.shared.updateImmediately = updateImmediately
        CoreConstants.shared.pauseSDK = pauseSDK
        CoreConstants.shared.autoShowInAppNudge = autoShowInAppNudge
        setup()
    }
    
    
    func updateUserId(appUserId: String) {
        if appUserId != "" {
            CoreConstants.shared.userId = appUserId
            CoreDataHelper.shared.writeUser(user: CoreConstants.shared.userId, deviceID: CoreConstants.shared.deviceObject?.id)
            userId = appUserId
            scheduleBackendNudgeListener()
        }
    }
    
    public func updateCoreCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateCoreCatalogItem(subject: subject, catalogObject: catalogObject)
    }
    
    
   
    @discardableResult
    func getSDKAccessKey() -> String? {
        guard let fileURL = URL(string: "Info.plist", relativeTo: nil) else {
            fatalError("Can't find Info.plist")
        }
        
        let contents = NSDictionary(contentsOf: fileURL) as? [String: String] ?? [:]
        
        return contents["ai.causalfoundry.iOS.sdk.APPLICATION_KEY"] ?? ""
    }
    
    public func track(contentBlockName: String, eventType: String, logObject: Any?, updateImmediately: Bool, eventTime: Int64 = 0) {
        
        verifyAccessToken()
        
        var cBlockName = contentBlockName
        if (cBlockName == ContentBlock.e_commerce.rawValue) {
            cBlockName = "e-commerce"
        }else if (contentBlockName == ContentBlock.e_learning.rawValue) {
            cBlockName = "e-learning"
        }
        
        ingestApiHandler.ingestTrackAPI(contentBlock: cBlockName, eventType: eventType, trackProperties: logObject!, updateImmediately: updateImmediately,eventTime: eventTime)
    }
    
    
    
    private func verifyAccessToken() {
        if CoreConstants.shared.sdkKey == "" {
            if getSDKAccessKey() == "" {
                fatalError("Access key not found")
            }else {
                CoreConstants.shared.sdkKey = "Bearer \(getSDKAccessKey()! )"
            }
        }
    }
    
    // Get Application Info Of app
    
    private func getApplicationInfo() -> AppInfo {
        let application = UIApplication.shared
        return AppInfo(id:application.bundleIdentifier(),
                       minSDKVersion: application.minimumVersion(),
                       targetSDKVersion: application.targetVersion(),
                       version:application.versionBuild(),
                       versionCode:application.appVersion() ,
                       versionName: application.build())
    }
    
    
    private func scheduleBackendNudgeListener() {
        // Code Reamining
    }
    
    public func getUSDRate(fromCurrency: String, callback: @escaping (Float) -> Float) {
        ingestApiHandler.getUSDRate(fromCurrency: fromCurrency, callback: callback)
    }
}


