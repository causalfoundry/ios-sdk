//
//  File.swift
//
//
//  Created by khushbu on 29/10/23.
//

import Foundation
import CasualFoundryCore
import CoreData

extension CoreDataHelper {
    
    // Currency Data
    func readCurrencyObject() -> CurrencyMainObject? {
        var currencyObject:CurrencyMainObject?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.currency.rawValue)
        do {
            let resultData = try context.fetch(fetchRequest)
            if resultData.count > 0 {
                let currencyData = resultData.first
                currencyObject = CurrencyMainObject(fromCurrency:currencyData?.value(forKey: "fromCurrency") as? String,
                                                    toCurrencyObject: CurrencyObject(date:(currencyData?.value(forKey: "fromCurrency") as? String)! ,usd:(currencyData?.value(forKey: "fromCurrency") as? Float)!))
                return currencyObject
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return  nil
    }
    
    
    func writeCurrencyObject(currency:CurrencyMainObject) {
        let managedContext = context
        let entity = NSEntityDescription.entity(forEntityName: TableName.currency.rawValue, in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set properties of the Core Data entity based on ExceptionDataObject properties
        
        managedObject.setValue(currency.fromCurrency, forKey: "fromCurrency")
        managedObject.setValue(currency.toCurrencyObject?.date, forKey: "conversionDate")
        managedObject.setValue(currency.toCurrencyObject?.usd, forKey: "toCurrency")
        // Add additional properties as needed
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
