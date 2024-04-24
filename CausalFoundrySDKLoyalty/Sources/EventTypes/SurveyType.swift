//
//  SurveyType.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CausalFoundrySDKCore
import Foundation

import Foundation

public enum SurveyType: String, EnumComposable {
    case openEnded = "open_ended"
    case closedEnded = "closed_ended"
    case nominal
    case likertScale = "likert_scale"
    case ratingScale = "rating_scale"
    case yesNo = "yes_no"
    case interview
    case other
}
