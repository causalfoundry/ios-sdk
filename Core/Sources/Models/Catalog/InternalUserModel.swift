//
//  InternalUserModel.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation


struct InternalUserModel: Codable {
    var id: String
    var name: String
    var country: String
    var region_state: String
    var city: String
    var workplace: String
    var profession: String
    var zipcode: String
    var language: String
    var experience: String
    var education_level: String
    var timezone: String
    var organization_id: String
    var organization_name: String
    
    init(id: String, name: String, country: String, region_state: String, city: String, workplace: String, profession: String, zipcode: String, language: String, experience: String, education_level: String, timezone: String, organization_id: String, organization_name: String) {
        self.id = id
        self.name = name
        self.country = country
        self.region_state = region_state
        self.city = city
        self.workplace = workplace
        self.profession = profession
        self.zipcode = zipcode
        self.language = language
        self.experience = experience
        self.education_level = education_level
        self.timezone = timezone
        self.organization_id = organization_id
        self.organization_name = organization_name
    }
}
