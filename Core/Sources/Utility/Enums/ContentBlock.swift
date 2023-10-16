//
//  File.swift
//  
//
//  Created by khushbu on 11/09/23.
//

import Foundation


public enum ContentBlock: String,HasOnlyAFixedSetOfPossibleValues,EnumComposable{
   case core,
    e_learning,
    e_commerce,
    payment,
    social,
    loyalty,
    chw_mgmt
    static var allValues: [ContentBlock] =  ContentBlock.allValues
}
