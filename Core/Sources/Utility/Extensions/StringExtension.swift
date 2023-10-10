//
//  File.swift
//  
//
//  Created by khushbu on 09/10/23.
//

import Foundation


extension String {
    func isNilOREmpty() -> Bool {
        if self == nil{
            return true
        }else if self == "" {
            return true
        }else {
            return false
        }
    }
}
