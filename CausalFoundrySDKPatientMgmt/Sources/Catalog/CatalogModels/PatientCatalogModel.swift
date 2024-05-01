//
//  PatientCatalogModel.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation

public struct PatientCatalogModel: Codable {
    var country: String
    var regionState: String
    var city: String
    var profession: String
    var educationLevel: String
    var siteIdsList: [String]
    var nationalId: String
    var insuranceId: String
    var insuranceType: String
    var insuranceStatus: Bool
    var landmark: String
    var phoneNumberCategory: String
    var programId: String
    
    public enum CodingKeys: String, CodingKey {
        case country
        case regionState = "region_state"
        case city
        case profession
        case educationLevel = "education_level"
        case siteIdsList = "site_ids_list"
        case nationalId = "national_id"
        case insuranceId = "insurance_id"
        case insuranceType = "insurance_type"
        case insuranceStatus = "insurance_status"
        case landmark
        case phoneNumberCategory = "phone_number_category"
        case programId = "program_id"
    }

    public init(country: String  = "", regionState: String = "", city: String = "", profession: String = "", educationLevel: String = "", siteIdsList: [String] = [], nationalId: String = "", insuranceId: String = "", insuranceType: String = "", insuranceStatus: Bool = false, landmark: String = "", phoneNumberCategory: String = "", programId: String = "") {
        
        self.country = country
        self.regionState = regionState
        self.city = city
        self.profession = profession
        self.educationLevel = educationLevel
        self.siteIdsList = siteIdsList
        self.nationalId = nationalId
        self.insuranceId = insuranceId
        self.insuranceType = insuranceType
        self.insuranceStatus = insuranceStatus
        self.landmark = landmark
        self.phoneNumberCategory = phoneNumberCategory
        self.programId = programId
    }
}
