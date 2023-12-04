//
//  File.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation

public enum  CatalogSubject: String, CaseIterable, Codable {
    case user = "user"
    case media = "media"
    case chw = "chw"
    case chwsite = "chwsite"
    case patient = "patient"
    
    
    case drug = "drug"
    case grocery = "grocery"
    case blood = "blood"
    case oxygen = "oxygen"
    case medical_equipment = "medical_equipment"
    case facility = "facility"
    
    
    case survey = "survey"
    case reward = "reward"
    
}
