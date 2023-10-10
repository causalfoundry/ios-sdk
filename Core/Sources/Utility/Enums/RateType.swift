//
//  File.swift
//  
//
//  Created by khushbu on 10/10/23.
//

import Foundation


public enum RateType: String,EnumComposable {
    static var allValues: [RateType] = RateType.allValues
    
    case order = "order"
    case item = "item"
    case media = "media"
    case exam = "exam"
    case question = "question"
    case module = "module"
    case process = "process"
    case form = "form"
    case section = "section"
    case app = "app"
    case other = "other"
}
