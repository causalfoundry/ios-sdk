//
//  IngestAPIHandler+Extension.swift
//
//
//  Created by khushbu on 29/10/23.
//

import Foundation
import CasualFoundryCore


extension IngestAPIHandler {
    
    public func getUSDRate(fromCurrency: String, callback: @escaping (Float) -> Float) async {
        let currencyObject: CurrencyMainObject? = CoreDataHelper.shared.readCurrencyObject()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let currencyObject = currencyObject,
            currencyObject.fromCurrency == fromCurrency,
            let toCurrencyObject = currencyObject.toCurrencyObject,
           toCurrencyObject.date == dateFormatter.string(from: Date()) || CoreConstants.shared.isAgainRate {
                _ = callback(toCurrencyObject.usd)
        } else {
            do {
               _ =  try await callCurrencyApi(fromCurrency: fromCurrency)
            }catch {
                
            }
            
        }
        
        CoreConstants.shared.isAgainRate = true
    }
 

    public func callCurrencyApi(fromCurrency: String) async throws -> Float {
        return try await withCheckedThrowingContinuation { continuation in
            let context = CoreConstants.shared.application
            Task {
                let currencyObject = CurrencyMainObject(
                    fromCurrency: fromCurrency,
                    toCurrencyObject: CurrencyObject(
                        date: "",
                        usd: CoreConstants.shared.getCurrencyFromLocalStorage(fromCurrency:fromCurrency )
                ))
                let usdRate = currencyObject.toCurrencyObject?.usd ?? 0.0

                continuation.resume(returning: usdRate)
            }
        }
    }

}


