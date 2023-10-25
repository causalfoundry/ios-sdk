//
//  File.swift
//  
//
//  Created by khushbu on 09/10/23.
//

import Foundation


public struct MediaCatalogModel:Codable,Equatable{
    
    let name:String?
    let description:String?
    let length:String?
    let resolution:String?
    var language:String?
    
    
   public init(name: String? = nil, description: String? = nil, length: String? = nil, resolution: String? = nil, language: String? = nil) {
        self.name = name
        self.description = description
        self.length = length
        self.resolution = resolution
        self.language = language
    }
    
    
    
}
