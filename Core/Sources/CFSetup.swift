//
//  CFSetup.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit
import FileProvider


class CFSetup:NSObject, IngestProtocol {
    
    private var ingestApiHandler = IngestAPIHandler()
    private var catalogAPIHandler = CatalogAPIHandler()
    private var userId: String? = nil
    
    
    private func setup(context:UIApplication)   {
        verifyAccessToken(context:context)
        CoreConstants.shared.deviceObject = DInfo(brand:"Apple" , id: UIDevice.current.identifierForVendor!.uuidString, model: UIDevice.modelName, os: "iOS", osVer:"\(UIDevice.current.systemVersion)")
        
        CoreConstants.shared.appInfoObject = self.getApplicationInfo(application: CoreConstants.shared.application!)
        CoreConstants.shared.sessionStartTime = Int64(Date().timeIntervalSinceNow)
        CoreConstants.shared.sessionEndTime = Int64(Date().timeIntervalSinceNow)
        
        // Need to Implement Below Code
        //        userId = PaperObject.readString(CoreConstants.userIdKey)
        //                if (!userId.isNullOrEmpty()) {
        //                    scheduleBackendNudgeListener()
        //                }
    }
    
    func initalize(application: UIApplication, event: UIApplication.State, pauseSDK: Bool, autoShowInAppNudge: Bool, updateImmediately: Bool) {
        CoreConstants.shared.application = application
        CoreConstants.shared.isAppDebuggable = true
        CoreConstants.shared.updateImmediately = updateImmediately
        CoreConstants.shared.pauseSDK = pauseSDK
        CoreConstants.shared.autoShowInAppNudge = autoShowInAppNudge
        self.setup(context:application)
    }
    
    
    func updateUserId(appUserId: String) {
        if userId != "" && CoreConstants.shared.application != nil {
            // update a UserdID in Database
            userId = appUserId
            CoreConstants.shared.userId = appUserId
            scheduleBackendNudgeListener()
        }
    }
    
    func getUSDRate(fromCurrency: String, callback: (Float) -> Float) {
        
    }
    
    func updateCatalogItem(subject: CatalogSubject, catalogObject: Any?) {
        
    }
    
    @discardableResult
    func getSDKAccessKey() -> String? {
        guard let fileURL = URL(string: "Info.plist", relativeTo: nil) else {
            fatalError("Can't find Info.plist")
        }
        
        let contents = NSDictionary(contentsOf: fileURL) as? [String: String] ?? [:]
        
        return contents["ai.causalfoundry.iOS.sdk.APPLICATION_KEY"] ?? ""
    }
    
    func track(contentBlockName: String, eventType: String, logObject: Any?, updateImmediately: Bool, eventTime: Int64) {
        
        if CoreConstants.shared.application != nil {
            verifyAccessToken(context:CoreConstants.shared.application!)
        }
        var cBlockName = contentBlockName
        if (cBlockName == ContentBlock.e_commerce.rawValue) {
            cBlockName = "e-commerce"
        }else if (contentBlockName == ContentBlock.e_learning.rawValue) {
            cBlockName = "e-learning"
        }
        
        ingestApiHandler.ingestTrackAPI(contentBlock: cBlockName, eventType: eventType, trackProperties: logObject, updateImmediately: updateImmediately,eventTime: eventTime)
    }
    
    
    
    private func verifyAccessToken(context:UIApplication) {
        if CoreConstants.shared.sdkKey == "" {
            if getSDKAccessKey() == "" {
                fatalError("Access key not found")
            }else {
                CoreConstants.shared.sdkKey = "Bearer \(getSDKAccessKey()! )"
            }
        }
    }
    
    // Get Application Info Of app
    
    private func getApplicationInfo(application:UIApplication) -> AppInfo {
        return AppInfo(id:application.bundleIdentifier(),
                       minSDKVersion: application.minimumVersion(),
                       targetSDKVersion: application.targetVersion(),
                       version:application.versionBuild(),
                       versionCode: application.appVersion(),
                       versionName: application.build())
    }
    
    
    private func scheduleBackendNudgeListener() {
        // Code Reamining
    }

}


