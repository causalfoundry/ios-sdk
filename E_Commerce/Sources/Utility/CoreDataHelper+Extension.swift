//
//  File.swift
//  
//
//  Created by khushbu on 29/10/23.
//

import Foundation



extension CoreDataHelper {
    
    // Currency Data
    
    func readCurrencyObject()-> CurrencyMainObject{
        
        
    }
    
    func writeCurrencyObject(currency:CurrencyMainObject) {
        let managedContext = context
        let entity = NSEntityDescription.entity(forEntityName: TableName.currency.rawValue, in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set properties of the Core Data entity based on ExceptionDataObject properties
       
        managedObject.setValue(currency.fromCurrency, forKey: "fromCurrency")
        managedObject.setValue(currency.CurrencyObject.date, forKey: "conversionDate")
        managedObject.setValue(currency.CurrencyObject.usd, forKey: "toCurrency")
        // Add additional properties as needed
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
}
