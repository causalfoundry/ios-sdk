//
//  SearchModuleType.swift
//
//
//  Created by khushbu on 16/10/23.
//

import Foundation

public enum SearchModuleType: String, EnumComposable {
    case core,
         screening,
         assessment,
         enrolment,
         medical_review,
         my_patients,
         prescription,
         lifestyle_mgmt,
         investigation,
         treatment_plan,
         transfers,
         other
}
