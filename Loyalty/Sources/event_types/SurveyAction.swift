//
//  SurveyAction.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation
import CasualFoundryCore

public enum SurveyAction: String, Codable,EnumComposable {
    case view
    case impression
    case start
    case submit
}
