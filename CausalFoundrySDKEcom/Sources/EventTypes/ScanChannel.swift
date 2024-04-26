//
//  ScanChannel.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ScanChannel: String, EnumComposable {
    case App
    case Ussd
    
    public var rawValue: String {
        switch self {
        case .App: return "app"
        case .Ussd: return "ussd"
        }
    }
    
}
