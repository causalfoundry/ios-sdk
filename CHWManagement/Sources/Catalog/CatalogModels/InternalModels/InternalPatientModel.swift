//
//  InternalPatientModel.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation

struct InternalPatientModel: Codable {
    var id: String = ""
    var country: String = ""
    var regionState: String = ""
    var city: String = ""
    var profession: String = ""
    var educationLevel: String = ""
    var siteIdsList: [String] = []
    var nationalId: String = ""
    var insuranceId: String = ""
    var insuranceType: String = ""
    var insuranceStatus: Bool = false
    var landmark: String = ""
    var phoneNumberCategory: String = ""
    var programId: String = ""

    init(id: String, country: String, regionState: String, city: String, profession: String, educationLevel: String, siteIdsList: [String], nationalId: String, insuranceId: String, insuranceType: String, insuranceStatus: Bool, landmark: String, phoneNumberCategory: String, programId: String) {
        self.id = id
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
