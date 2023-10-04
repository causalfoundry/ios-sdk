//
//  UIApplication.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation
import UIKit


extension UIApplication {
    var icon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? NSDictionary,
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? NSDictionary,
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? NSArray,
            // First will be smallest for the device class, last will be the largest for device class
            let lastIcon = iconFiles.lastObject as? String,
            let icon = UIImage(named: lastIcon) else {
                return nil
        }

        return icon
    }

    func appVersion() -> Int {
        if let appVersionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
           // return "\(appVersionNumber)"
            return 11
        } else {
            return 0
        }
    }

    func build() -> String {
        if let buildVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) {
            return "\(buildVersion)"
        } else {
            return ""
        }
    }

    func versionBuild() -> String {
        var versionString:String = ""
        let versionNumber:String = "\(self.appVersion())"
        let build:String = self.build()
        versionString = "\(versionNumber)\(build)"

        return  versionString
    }
    
    func bundleIdentifier() -> String {
        return Bundle.main.bundleIdentifier ?? "0.0"
    }


    func targetVersion() -> Int {
        return 17
      //  return "0.0"
       
    }
     
    func minimumVersion() -> Int{
        if let appVersionNumber = Bundle.main.object(forInfoDictionaryKey: "MinimumOSVersion") {
            //return "\(appVersionNumber)"
            return 31
        } else {
            return 0
        }
        
    }
}
