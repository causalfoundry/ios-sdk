//
//  CatalogSubject.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation

public enum CatalogSubject: String, CaseIterable, Codable {
    case user
    case media
    case chw
    case chwsite
    case patient

    case drug
    case grocery
    case blood
    case oxygen
    case medical_equipment
    case facility

    case survey
    case reward
}
