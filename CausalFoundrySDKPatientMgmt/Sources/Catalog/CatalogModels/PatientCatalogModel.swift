//
//  PatientCatalogModel.swift
//
//
//  Created by Moiz Hassan Khan on 19/09/24.
//

import Foundation

public struct PatientCatalogModel: Codable {
    var patientId: String
    var country: String?
    var regionState: String?
    var city: String?
    var profession: String?
    var educationLevel: String?
    var siteIdList: [String]?
    var insuranceId: String?
    var insuranceType: String?
    var insuranceStatus: Bool?
    var landmark: String?
    var phoneNumberCategory: String?
    var programId: String?
    var familyId: String?
    var hwIdList: [String]?
    var buddyIdList: [String]?
    var transportMode: String?
    var maritalStatus: String?
    var employmentStatus: String?
    var nationality: String?
    var hasWhatsapp: Bool?
    var hasEmail: Bool?
    
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

    public init(patientId: String, country: String?  = "", regionState: String? = "", city: String? = "", profession: String? = "", educationLevel: String? = "", siteIdList: [String]? = [], insuranceId: String? = "", insuranceType: String? = "", insuranceStatus: Bool? = false, landmark: String? = "", phoneNumberCategory: String? = "", programId: String? = "", familyId: String? = "", hwIdList: [String]? = [], buddyIdList: [String]? = [], transportMode: String? = "", maritalStatus: String? = "", employmentStatus: String? = "", nationality: String? = "", hasWhatsapp: Bool? = false, hasEmail: Bool? = false) {
        
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
    
    
    // MARK: - Encoding
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(patientId, forKey: .patientId)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(regionState, forKey: .regionState)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(profession, forKey: .profession)
        try container.encodeIfPresent(educationLevel, forKey: .educationLevel)
        try container.encodeIfPresent(siteIdList, forKey: .siteIdList)
        try container.encodeIfPresent(insuranceId, forKey: .insuranceId)
        try container.encodeIfPresent(insuranceType, forKey: .insuranceType)
        try container.encodeIfPresent(insuranceStatus, forKey: .insuranceStatus)
        try container.encodeIfPresent(landmark, forKey: .landmark)
        try container.encodeIfPresent(phoneNumberCategory, forKey: .phoneNumberCategory)
        try container.encodeIfPresent(programId, forKey: .programId)
        try container.encodeIfPresent(familyId, forKey: .familyId)
        try container.encodeIfPresent(hwIdList, forKey: .hwIdList)
        try container.encodeIfPresent(buddyIdList, forKey: .buddyIdList)
        try container.encodeIfPresent(transportMode, forKey: .transportMode)
        try container.encodeIfPresent(maritalStatus, forKey: .maritalStatus)
        try container.encodeIfPresent(employmentStatus, forKey: .employmentStatus)
        try container.encodeIfPresent(nationality, forKey: .nationality)
        try container.encodeIfPresent(hasWhatsapp, forKey: .hasWhatsapp)
        try container.encodeIfPresent(hasEmail, forKey: .hasEmail)
        
        
    }

    // MARK: - Decoding

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try container.decode(String.self, forKey: .patientId)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        regionState = try container.decodeIfPresent(String.self, forKey: .regionState)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        profession = try container.decodeIfPresent(String.self, forKey: .profession)
        educationLevel = try container.decodeIfPresent(String.self, forKey: .educationLevel)
        siteIdList = try container.decodeIfPresent([String].self, forKey: .siteIdList)
        insuranceId = try container.decodeIfPresent(String.self, forKey: .insuranceId)
        insuranceType = try container.decodeIfPresent(String.self, forKey: .insuranceType)
        insuranceStatus = try container.decodeIfPresent(Bool.self, forKey: .insuranceStatus)
        landmark = try container.decodeIfPresent(String.self, forKey: .landmark)
        phoneNumberCategory = try container.decodeIfPresent(String.self, forKey: .phoneNumberCategory)
        programId = try container.decodeIfPresent(String.self, forKey: .programId)
        familyId = try container.decodeIfPresent(String.self, forKey: .familyId)
        hwIdList = try container.decodeIfPresent([String].self, forKey: .hwIdList)
        buddyIdList = try container.decodeIfPresent([String].self, forKey: .buddyIdList)
        transportMode = try container.decodeIfPresent(String.self, forKey: .transportMode)
        maritalStatus = try container.decodeIfPresent(String.self, forKey: .maritalStatus)
        employmentStatus = try container.decodeIfPresent(String.self, forKey: .employmentStatus)
        nationality = try container.decodeIfPresent(String.self, forKey: .nationality)
        hasWhatsapp = try container.decodeIfPresent(Bool.self, forKey: .hasWhatsapp)
        hasEmail = try container.decodeIfPresent(Bool.self, forKey: .hasEmail)
    }
    
}

