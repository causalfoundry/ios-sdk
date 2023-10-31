//
//  CurrencyObject.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

public struct CurrencyObject: Codable {
    var date: String
    var usd: Float
    
    init(date: String, usd: Float) {
        self.date = date
        self.usd = usd
    }
}
