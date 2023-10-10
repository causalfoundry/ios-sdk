//
//  File.swift
//
//
//  Created by khushbu on 09/10/23.
//

import Foundation


public enum  MediaAction :String,HasOnlyAFixedSetOfPossibleValues{
    case view = "View"
    case play = "play"
    case pause = "pause"
    case seek = "seek"
    case finish = "finish"
    case impression = "impression"
    
    static var allValues: [MediaAction] =  MediaAction.allValues
}

