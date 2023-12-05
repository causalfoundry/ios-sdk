//
//  SurveyAction.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CasualFoundryCore
import Foundation

public enum SurveyAction: String, Codable, EnumComposable {
    case view
    case impression
    case start
    case submit
}
