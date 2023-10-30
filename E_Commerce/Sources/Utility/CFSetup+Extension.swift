//
//  File.swift
//  
//
//  Created by khushbu on 29/10/23.
//

import Foundation
import CasualFoundryCore


extension CFSetup {
    
    func getUSDRate(fromCurrency: String, callback: (Float) -> Float) {
        if CoreConstants.shared.application != nil {
            ingestApiHandler.getUSDRate(fromCurrency: fromCurrency) { value  in
                return value
            }
        }
    }
}
