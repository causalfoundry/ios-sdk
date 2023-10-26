//
//  File 2.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import Foundation


public enum ChwModuleType: String {
    case screening
    case assessment
    case enrolment
    case medicalReview = "medical_review" // Swift enum cases with underscores require raw values
    case myPatients = "my_patients"
    case prescription
    case transfers
    case lifestyleMgmt = "lifestyle_mgmt"
    case investigation
    case treatmentPlan = "treatment_plan"
    case other
}

