//
//  EducationalLevel.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation

public enum EducationalLevel: String, CaseIterable, EnumComposable {
    case primary
    case lowerSecondary = "lower_secondary"
    case upperSecondary = "upper_secondary"
    case nonTertiary = "non_tertiary"
    case tertiary
    case bachelors
    case masters
    case doctorate
}
