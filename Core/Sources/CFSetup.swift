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
    
    private func scheduleBackendNudgeListener() {
        // Need to Implement Below Code
        //            val nudgeScheduler = BackendNudgeScheduler()
        //            nudgeScheduler.backendNudgeScheduler(CoreConstants.application!!.applicationContext)
    }
    
    
    
    func updateUserId(appUserId: String) {
        
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
}


