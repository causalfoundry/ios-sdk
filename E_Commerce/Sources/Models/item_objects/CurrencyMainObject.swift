//
//  CurrencyMainObject.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation


public struct CurrencyMainObject {
    var fromCurrency: String?
    var toCurrencyObject: CurrencyObject?
    
   public  init(fromCurrency: String? = nil, toCurrencyObject: CurrencyObject? = nil) {
        self.fromCurrency = fromCurrency
        self.toCurrencyObject = toCurrencyObject
    }
}
w
