//
//  CFInAppMessage.swift
//
//
//  Created by MOIZ HASSAN KHAN on 25/4/24.
//

import Foundation

public class CFInAppMessage {
    public static func show(actionScreenType: ActionScreenType) {
        CFActionListener.shared.showInAppMessages(actionScreenType: actionScreenType)
    }
    
    public static func show(actionScreenType: String) {
        
        if ActionScreenType(rawValue: actionScreenType) == nil {
            ExceptionManager.throwEnumException(eventType: "InApp Message Fetch", className: "ActionScreenType")
        }
        CFActionListener.shared.showInAppMessages(actionScreenType: ActionScreenType(rawValue: actionScreenType)!)
    }
}
