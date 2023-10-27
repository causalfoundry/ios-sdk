//
//  File.swift
//  
//
//  Created by khushbu on 26/10/23.
//

import Foundation

public struct LifestylePlanItem: Codable {
    var name: String
    var action: String
    var remarks: String?
    
    public init(name: String, action: String, remarks: String? = nil) {
        self.name = name
        self.action = action
        self.remarks = remarks
    }
    
       public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(name, forKey: .name)
           try container.encode(action, forKey: .action)
           try container.encodeIfPresent(remarks, forKey: .remarks)
       }
       
       private enum CodingKeys: String, CodingKey {
           case name
           case action
           case remarks
       }

       // Decoding
       public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           name = try container.decode(String.self, forKey: .name)
           action = try container.decode(String.self, forKey: .action)
           remarks = try container.decodeIfPresent(String.self, forKey: .remarks)
       }
}
