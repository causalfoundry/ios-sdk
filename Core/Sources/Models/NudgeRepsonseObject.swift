//
//  NudgeRepsonseObject.swift
//
//
//  Created by Causal Foundry on 01.12.23.
//

import Foundation

struct NudgeRepsonseObject: Codable {
    enum NudgeRepsonse: String, Encodable {
        case open // When the user taps on the nudge to open it.
        case discard // when the user swipes on the push notification to discard it. for in-app, taping on the X to close the nudge.
        case block // if the user has blocked the permission for push notifications, not effective for in-app messages.
        case shown // when the nudge is shown to the user, sent to the OS for showing up as a push notification and when the nudge is rendered on screen for the in-app message.
        case error // when there is some error in rendering the nudge for both push notification and in-app message, such as nudge body rendering
    }

    let ref: String // ref provided in the nudge fetch API.
    let response: String // open, shown, error, block
    let details: String // reason for error
    let time: String

    init(nudgeRef: String, response: NudgeRepsonse) {
        ref = nudgeRef
        self.response = response.rawValue
        details = ""
        time = ISO8601DateFormatter().string(from: Date())
    }
}
