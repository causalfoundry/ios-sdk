//
//  InternalUserModel.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation

struct InternalUserModel: Codable {
    var id: String
    var name: String?
    var country: String?
    var region_state: String?
    var city: String?
    var workplace: String?
    var profession: String?
    var zipcode: String?
    var language: String?
    var experience: String?
    var education_level: String?
    var timezone: String
    var organization_id: String?
    var organization_name: String?
    var account_type: String?
    var birth_year: Int?
    var gender: String?
    var marital_status: String?
    var family_members: String?
    var children_under_five: String?

        
    public init(id: String, name: String? = "", country: String? = "", regionState: String? = "", city: String? = "", workplace: String? = "", profession: String? = "", zipcode: String? = "", language: String? = "", experience: String? = "", educationLevel: String? = "", timezone: String, organizationId: String? = "", organizationName: String? = "", accountType: String? = "", birthYear: Int? = 0, gender: String? = "", maritalStatus: String? = "", familyMembers: String? = "", childrenUnderFive: String? = "") {
            
        self.id = id
        self.name = name
        self.country = country
        self.region_state = regionState
        self.city = city
        self.workplace = workplace
        self.profession = profession
        self.zipcode = zipcode
        self.language = language
        self.experience = experience
        self.education_level = educationLevel
        self.timezone = timezone
        self.organization_id = organizationId
        self.organization_name = organizationName
        self.account_type = accountType
        self.birth_year = birthYear
        self.gender = gender
        self.marital_status = maritalStatus
        self.family_members = familyMembers
        self.children_under_five = childrenUnderFive
    }
}
