//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 13/12/23.
//

import Foundation

public protocol NudgeOnClickInterface: AnyObject {
    func openedNudge(cta: String, itemType: String, itemID: String)
}

public class NudgeOnClickObject {
    public static var nudgeOnClickInterface: NudgeOnClickInterface?

    public static func setNudgeOnClickInterface(_ callback: NudgeOnClickInterface) {
        nudgeOnClickInterface = callback
    }
}
