//
//  SearchItemType.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public enum SearchItemType: String,HasOnlyAFixedSetOfPossibleValues,EnumComposable {
   
    
    case blood
    case oxygen
    case drug
    case grocery
    case facility
    case medicalEquipment

    case electronics
    case clothing
    case book

    case patientRecord
    case lifestylePlanItem
    case investigationTestItem
    case treatmentPlanItem
    case other

    static var allValues: [SearchItemType] = SearchItemType.allValues
    
    // Function to check if a rawValue belongs to the enum
    static func contains(rawValue: String) -> Bool {
        return SearchItemType(rawValue: rawValue) != nil
    }
}


