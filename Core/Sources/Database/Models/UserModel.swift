//
//  File.swift
//  
//
//  Created by khushbu on 11/10/23.
//

import Foundation
import CoreData

@objc(UserModel)
class UserModel: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var deviceID: String
}

