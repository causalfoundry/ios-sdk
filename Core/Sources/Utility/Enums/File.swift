//
//  File.swift
//  
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public enum SearchItemType: String,HasOnlyAFixedSetOfPossibleValues {
    static var allValues: [SearchItemType] = SearchItemType.allValues
    
    case blood = "blood"
    case oxygen = "oxygen"
    case drug = "drug"
    case grocery = "grocery"
    case facility = "facility"
    case medicalEquipment = "medicalEquipment"

    case electronics = "electronics"
    case clothing = "clothing"
    case book = "book"

    case patientRecord = "patientRecord"
    case lifestylePlanItem = "lifestylePlanItem"
    case investigationTestItem = "investigationTestItem"
    case treatmentPlanItem = "treatmentPlanItem"
    case other = "other"

    // Function to check if a rawValue belongs to the enum
    static func contains(rawValue: String) -> Bool {
        return SearchItemType(rawValue: rawValue) != nil
    }
}


