//
//  File.swift
//  
//
//  Created by khushbu on 09/10/23.
//

import Foundation


public enum  MediaType:String, HasOnlyAFixedSetOfPossibleValues{
    case audio = "audio"
    case video = "video"
    case image = "image"
    
    static var allValues: [MediaType] =  MediaType.allValues
}
