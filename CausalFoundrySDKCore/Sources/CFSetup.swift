//
//  CFSetup.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit

public class CFSetup: NSObject, IngestProtocol {
    public let ingestApiHandler = IngestAPIHandler()
    public let catalogAPIHandler = CatalogAPIHandler()

    private func setup() {
        verifyAccessToken()
        CoreConstants.shared.deviceObject = DInfo(brand: "Apple", id: UIDevice.current.identifierForVendor!.uuidString, model: UIDevice.modelName, os: "iOS", osVer: "\(UIDevice.current.systemVersion)")

        CoreConstants.shared.appInfoObject = getApplicationInfo()

        // Change implementation

        CoreConstants.shared.sessionStartTime = Int64(Date().timeIntervalSince1970 * 1000)
        CoreConstants.shared.sessionEndTime = Int64(Date().timeIntervalSince1970 * 1000)
        CFNudgeListener.shared.beginListening()
    }

    func initalize(pauseSDK: Bool, updateImmediately: Bool) {
        #if DEBUG
        CoreConstants.shared.isAppDebuggable = true
        #else
        CoreConstants.shared.isAppDebuggable = false
        #endif
        CoreConstants.shared.updateImmediately = updateImmediately
        CoreConstants.shared.pauseSDK = pauseSDK
        setup()
    }

    func updateUserId(appUserId: String) {
        if !appUserId.isEmpty {
            CoreConstants.shared.userId = appUserId
            MMKVHelper.shared.writeUserBackup(userId: appUserId)
            CFNudgeListener.shared.beginListening()
        }
    }

    public func updateCoreCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        
        print("subject 1: \(subject)")
        print("subject 1A: \(catalogObject)")
        let oldData = MMKVHelper.shared.readCatalogData(subject: subject) ?? Data()
        print("subject 2A: \(oldData)")
        let newData = MMKVHelper.shared.getCoreCatalogTypeData(newData: catalogObject, oldData: oldData, subject: subject)
        print("subject 2: \(newData)")
        catalogAPIHandler.updateCoreCatalogItem(subject: subject, catalogObject: newData ?? catalogObject)
    }

    public func track<T: Codable>(contentBlockName: String, eventType: String, logObject: T?, updateImmediately: Bool, eventTime: Int64 = 0) {
        verifyAccessToken()

        var cBlockName = contentBlockName
        if cBlockName == ContentBlock.ECommerce.rawValue {
            cBlockName = "e-commerce"
        } else if contentBlockName == ContentBlock.ELearning.rawValue {
            cBlockName = "e-learning"
        }

        ingestApiHandler.ingestTrackAPI(contentBlock: cBlockName, eventType: eventType, trackProperties: logObject, updateImmediately: updateImmediately, eventTime: eventTime)
    }

    private func verifyAccessToken() {
        if CoreConstants.shared.sdkKey.isEmpty {
            fatalError("Access key not found")
        }
    }

    // Get Application Info Of app

    private func getApplicationInfo() -> AppInfo {
        let application = UIApplication.shared
        return AppInfo(id: application.bundleIdentifier(),
                       minSDKVersion: application.minimumVersion(),
                       targetSDKVersion: application.targetVersion(),
                       version: application.versionBuild(),
                       versionCode: application.build(),
                       versionName: application.appVersion())
    }
}
