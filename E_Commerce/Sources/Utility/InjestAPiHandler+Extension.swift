//
//  IngestAPIHandler+Extension.swift
//
//
//  Created by khushbu on 29/10/23.
//

import Foundation
import CasualFoundryCore


extension IngestAPIHandler {
    
    public func getUSDRate(fromCurrency: String, callback: @escaping (Float) -> Float) {
        let currencyObject: CurrencyMainObject? = CoreDataHelper.shared.readCurrencyObject()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let currencyObject = currencyObject,
            currencyObject.fromCurrency == fromCurrency,
            let toCurrencyObject = currencyObject.toCurrencyObject,
           toCurrencyObject.date == dateFormatter.string(from: Date()) || CoreConstants.shared.isAgainRate {
                _ = callback(toCurrencyObject.usd)
        } else {
           _ =  callCurrencyApi(fromCurrency: fromCurrency)
           
        }
        
        CoreConstants.shared.isAgainRate = true
    }
 

    public func callCurrencyApi(fromCurrency: String)  -> Float {
       let currencyObject = CurrencyMainObject(
                    fromCurrency: fromCurrency,
                    toCurrencyObject: CurrencyObject(
                        date: "",
                        usd: CoreConstants.shared.getCurrencyFromLocalStorage(fromCurrency:fromCurrency )
                ))
                let usdRate = currencyObject.toCurrencyObject?.usd ?? 0.0
                return usdRate
            }
        }
    



