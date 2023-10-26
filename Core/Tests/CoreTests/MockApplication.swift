//
//  MockApplication.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation
import UIKit

class MockApplication: UIApplication {
    var mockDelegate: UIApplicationDelegate?

    override var delegate: UIApplicationDelegate? {
        get {
            return mockDelegate
        }
        set {
            mockDelegate = newValue
        }
    }
   
}
