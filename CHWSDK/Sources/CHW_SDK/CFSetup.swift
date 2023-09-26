//
//  File.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit
import FileProvider


class CFSetup:IngestProtocol{
    
    private var ingestApiHandler = IngestAPIHandler()
    private var catalogAPIHandler = CatalogAPIHandler()
    private var userId: String? = nil
    
    func initalize(application: UIApplication, event: UIApplication.State, pauseSDK: Bool, autoShowInAppNudge: Bool, updateImmediately: Bool) {
       // verifyAccessToken(context:application)
        CoreConstants.shared.application = application
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
}


