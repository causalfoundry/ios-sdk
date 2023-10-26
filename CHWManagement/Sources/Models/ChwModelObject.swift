//
//  ChwModelObject.swift
//
//
//  Created by khushbu on 26/10/23.
//


import Foundation

struct ChwModelObject  {
    var type: String
    var meta: Any?
    
    init(type: String, meta: Any? = nil) {
        self.type = type
        self.meta = meta
    }
}

