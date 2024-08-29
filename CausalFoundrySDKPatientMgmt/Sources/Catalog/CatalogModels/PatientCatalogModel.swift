//
//  PatientCatalogModel.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation

public struct PatientCatalogModel: Codable {
    var patientId: String
    var country: String
    var regionState: String
    var city: String
    var profession: String
    var educationLevel: String
    var siteIdList: [String]
    var insuranceId: String
    var insuranceType: String
    var insuranceStatus: Bool
    var landmark: String
    var phoneNumberCategory: String
    var programId: String
    var familyId: String
    var hwIdList: [String]
    var buddyIdList: [String]
    var transportMode: String
    var maritalStatus: String
    var employmentStatus: String
    var nationality: String
    var hasWhatsapp: Bool
    var hasEmail: Bool
    
    public enum CodingKeys: String, CodingKey {
        case patientId = "id"
        case country
        case regionState = "region_state"
        case city
        case profession
        case educationLevel = "education_level"
        case siteIdList = "site_id_list"
        case insuranceId = "insurance_id"
        case insuranceType = "insurance_type"
        case insuranceStatus = "insurance_status"
        case landmark
        case phoneNumberCategory = "phone_number_category"
        case programId = "program_id"
        case familyId = "family_id"
        case hwIdList = "hw_id_list"
        case buddyIdList = "buddy_id_list"
        case transportMode = "transport_mode"
        case maritalStatus = "marital_status"
        case employmentStatus = "employment_status"
        case nationality = "nationality"
        case hasWhatsapp = "has_whatsapp"
        case hasEmail = "has_email"
    }

    public init(patientId: String, country: String  = "", regionState: String = "", city: String = "", profession: String = "", educationLevel: String = "", siteIdList: [String] = [], insuranceId: String = "", insuranceType: String = "", insuranceStatus: Bool = false, landmark: String = "", phoneNumberCategory: String = "", programId: String = "", familyId: String = "", hwIdList: [String] = [], buddyIdList: [String] = [], transportMode: String = "", maritalStatus: String = "", employmentStatus: String = "", nationality: String = "", hasWhatsapp: Bool = false, hasEmail: Bool = false) {
        
        self.patientId = patientId
        self.country = country
        self.regionState = regionState
        self.city = city
        self.profession = profession
        self.educationLevel = educationLevel
        self.siteIdList = siteIdList
        self.insuranceId = insuranceId
        self.insuranceType = insuranceType
        self.insuranceStatus = insuranceStatus
        self.landmark = landmark
        self.phoneNumberCategory = phoneNumberCategory
        self.programId = programId
        self.familyId = familyId
        self.hwIdList = hwIdList
        self.buddyIdList = buddyIdList
        self.transportMode = transportMode
        self.maritalStatus = maritalStatus
        self.employmentStatus = employmentStatus
        self.nationality = nationality
        self.hasWhatsapp = hasWhatsapp
        self.hasEmail = hasEmail
    }
}
