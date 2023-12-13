//
//  RateType.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation

public enum RateType: String, CaseIterable, EnumComposable {
    case order
    case item
    case media
    case exam
    case question
    case module
    case process
    case form
    case section
    case app
    case other
}
