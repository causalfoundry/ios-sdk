//
//  SearchItemType.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public enum SearchItemType: String,EnumComposable {
    case blood,
     oxygen,
     drug,
     grocery,
     facility,
     medicalEquipment,
     electronics,
     clothing,
     book,
     patientRecord,
     lifestylePlanItem,
     investigationTestItem,
     treatmentPlanItem,
     other

    static var allValues: [SearchItemType] = SearchItemType.allValues
}


