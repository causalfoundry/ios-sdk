//
//  IdentityAction.swift
//
//
//  Created by khushbu on 28/09/23.
//

import Foundation

public enum  IdentityAction:String,HasOnlyAFixedSetOfPossibleValues {
    
    
    case register = "register"
    case login = "login"
    case logout = "logout"
    
    static var allValues: [IdentityAction] =  IdentityAction.allValues
}
