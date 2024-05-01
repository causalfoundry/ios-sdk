//
//  CFInAppMessage.swift
//
//
//  Created by MOIZ HASSAN KHAN on 25/4/24.
//

import Foundation

public class CFInAppMessage {
    public static func show(nudgeScreenType: NudgeScreenType) {
        CFNudgeListener.shared.showInAppMessages(nudgeScreenType: nudgeScreenType)
    }
    
    public static func show(nudgeScreenType: String) {
        
        if NudgeScreenType(rawValue: nudgeScreenType) == nil {
            ExceptionManager.throwEnumException(eventType: "InApp Message Fetch", className: "NudgeScreenType")
        }
        CFNudgeListener.shared.showInAppMessages(nudgeScreenType: NudgeScreenType(rawValue: nudgeScreenType)!)
    }
}
