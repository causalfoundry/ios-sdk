//
//  CoreDataHelper.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation
import CoreData
import UIKit

public class CoreDataHelper {
    
    public static let shared = CoreDataHelper()
    
    public init() {
        if persistentContainer == nil {
            
            // Create a Persistace container and user Table
            let usermodel = createManagedObjectModel()
            // Specify the file path where you want to save the model
            createEnitity(model:usermodel )
        }
        
    }
    
    var persistentContainer: NSPersistentContainer? {
        if let container = loadPersistentContainer() {
            return container
        }
        return nil
        
    }
    
    func loadPersistentContainer() -> NSPersistentContainer? {
        // Get the URL of the Core Data model in the Documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let modelURL = documentsDirectory.appendingPathComponent("_causulFoundry.xcdatamodeld")
        
        // Load the NSManagedObjectModel from the model URL
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            print("Failed to load the managed object model from \(modelURL)")
            return nil
        }
        
        // Initialize the NSPersistentContainer with the loaded model
        let persistentContainer = NSPersistentContainer(name: "_causulFoundry", managedObjectModel: model)
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        
        return persistentContainer
    }
    
    func createManagedObjectModel() -> NSManagedObjectModel {
        let managedObjectModel = NSManagedObjectModel()
        managedObjectModel.entities = [self.userEntity(),self.exceptionEntity(),self.currencyEntity(),self.userCatalogEntity(),self.userEventsEntity(),self.catalogEntity()]
        return managedObjectModel
    }
    
    
    func saveManagedObjectModelToFile(model: NSManagedObjectModel, filePath: URL) {
        // Convert the managed object model to data
        guard let modelData = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: true) else {
            print("Failed to archive model data.")
            return
        }
        // Write the data to the specified file path
        do {
            try modelData.write(to: filePath)
            print("Managed object model saved successfully at: \(filePath.path)")
        } catch {
            print("Error saving managed object model: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Core Data Context
    
    public var context: NSManagedObjectContext {
        return persistentContainer!.viewContext
    }
    
    // MARK: - Core Data Operations
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}




extension CoreDataHelper {
    // GET ALL EXCEPTION LOGS
    func readExceptionsData() -> [ExceptionDataObject]{
        var itemData:[ExceptionDataObject]? = []
        if let existingEntity = NSEntityDescription.entity(forEntityName:TableName.exceptionData.rawValue, in: context) {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: existingEntity.name!)
            do {
                let items = try context.fetch(fetchRequest)
                if items.count > 0 {
                    itemData =  items.map({ (data) in
                        let exceptionData = ExceptionDataObject(title: (data.value(forKey:"title") as? String ?? "" ) ,
                                                                eventType: data.value(forKey:"eventType") as? String  ?? "",
                                                                exceptionType: data.value(forKey:"exceptionType") as? String ?? "",
                                                                exceptionSource: data.value(forKey:"exceptionSource") as? String ?? "" ,
                                                                stackTrace: data.value(forKey:"stackTrace") as? String ?? "",
                                                                ts: data.value(forKey:"ts") as? String ??  "")
                        return exceptionData
                    })
                }else{
                    itemData = items as? [ExceptionDataObject]
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                
            }
        }else {
            
            
        }
        return itemData!
    }
    
    func createEnitity(model:NSManagedObjectModel) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let modelURL = documentsDirectory.appendingPathComponent("_causulFoundry.xcdatamodeld")
        saveManagedObjectModelToFile(model: model, filePath: modelURL)
        
    }
    
    func writeExceptionEvents(eventArray: [ExceptionDataObject]) {
        let managedContext = context
        
        let existingEntity = NSEntityDescription.entity(forEntityName: TableName.exceptionData.rawValue, in: managedContext)
        let managedObject = NSManagedObject(entity: existingEntity!, insertInto: managedContext)
        for exceptionDataObject in eventArray {
            
            // Set properties of the Core Data entity based on ExceptionDataObject properties
            managedObject.setValue(exceptionDataObject.title, forKey: "title")
            managedObject.setValue(exceptionDataObject.eventType, forKey: "eventType")
            managedObject.setValue(exceptionDataObject.exceptionType, forKey: "exceptionType")
            managedObject.setValue(exceptionDataObject.exceptionSource, forKey: "exceptionSource")
            managedObject.setValue(exceptionDataObject.stackTrace, forKey: "stackTrace")
            managedObject.setValue(exceptionDataObject.ts, forKey: "ts")
            
            // Add additional properties as needed
            
            
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func writeUser(user: String?,deviceID:String?) {
        
        let managedContext = context
        let entity = NSEntityDescription.entity(forEntityName: TableName.user.rawValue, in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set properties of the Core Data entity based on ExceptionDataObject properties
        managedObject.setValue(user, forKey: "userID")
        managedObject.setValue(deviceID, forKey: "deviceID")
        // Add additional properties as needed
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    // MARK: - Fetch User ID
    func fetchUserID(deviceID:String = "") -> String {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.user.rawValue)
        fetchRequest.predicate = NSPredicate(format: "deviceID == %@", deviceID)
        do {
            let items = try context.fetch(fetchRequest)
            let user:String = items.first?.value(forKey: "userID") as? String ?? ""
            return user
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return ""
    }
    
    func convertDataIntoEncodeable(contentBlock:String,eventType:String,resultData:Data) -> Encodable {
        var convertedData:Encodable?
        let decoder = JSONDecoder()
        do {
            if contentBlock == "core" {
                if eventType == "identity" {
                    convertedData =  try decoder.decode(IdentifyObject.self, from: resultData)
                }else if eventType == "app" {
                    convertedData =  try decoder.decode(AppObject.self, from: resultData)
                }else if eventType == "media" {
                    convertedData =  try decoder.decode(MediaObject.self, from: resultData)
                }else if eventType == "page" {
                    convertedData =  try decoder.decode(PageObject.self, from: resultData)
                }else if eventType == "rate" {
                    convertedData =  try decoder.decode(RateObject.self, from: resultData)
                }else if eventType == "search" {
                    convertedData =  try decoder.decode(SearchObject.self, from: resultData)
                }
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return convertedData!
    }
/**
     * To read user events from DB, default is empty list
     */
    func readEvents() -> [EventDataObject] {
        var itemData:[EventDataObject]? = []
        if let existingEntity = NSEntityDescription.entity(forEntityName:TableName.userEvents.rawValue, in: context) {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: existingEntity.name!)
            do {
                let items = try context.fetch(fetchRequest)
                if items.count > 0 {
                    itemData =  items.map({ (data) in
                        let entityData = EventDataObject(content_block: (data.value(forKey:"content_block") as? String ?? "" ) ,
                                                         online:(data.value(forKey:"online") as? Bool ??  false ) ,
                                                         ts: (data.value(forKey:"ts") as? String ?? "" ) ,
                                                         event_type: (data.value(forKey:"event_type") as? String ?? "" ) ,
                                                         event_properties: self.convertDataIntoEncodeable(contentBlock: (data.value(forKey:"content_block") as? String ?? "" ), resultData:data.value(forKey:"event_properties") as! Data))
                        return entityData
                    })
                }else{
                    itemData = items as? [EventDataObject]
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                
            }
        }else {
            
            
        }
        return itemData!
        
    }
    /**
     * To write user events in DB
     */
    func writeEvents(eventsArray:[EventDataObject]) {
        let managedContext = context
        
        let existingEntity = NSEntityDescription.entity(forEntityName: TableName.userEvents.rawValue, in: managedContext)
        let managedObject = NSManagedObject(entity: existingEntity!, insertInto: managedContext)
        for eventDataObject in eventsArray {
            
            // Set properties of the Core Data entity based on ExceptionDataObject properties
            managedObject.setValue(eventDataObject.content_block, forKey: "content_block")
            managedObject.setValue(eventDataObject.online, forKey: "online")
            managedObject.setValue(eventDataObject.ts, forKey: "ts")
            managedObject.setValue(eventDataObject.event_type, forKey: "event_type")
            managedObject.setValue(eventDataObject.event_properties?.toData(), forKey: "event_properties")
            // Add additional properties as needed
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func readUserCatalog() -> UserCatalogModel? {
        var userCataLogItem:UserCatalogModel?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.userCatalog.rawValue)
        do {
            let resultData = try context.fetch(fetchRequest)
            if resultData.count > 0 {
                let userData = resultData.first
                userCataLogItem =  UserCatalogModel(name: userData?.value(forKey:"name") as? String ?? "",
                                                    country: userData?.value(forKey:"country") as? String ?? "",
                                                    region_state: userData?.value(forKey:"region_state") as? String ?? "",
                                                    city: userData?.value(forKey:"city") as? String ?? "",
                                                    workplace: userData?.value(forKey:"workplace") as? String ?? "",
                                                    profession: userData?.value(forKey:"profession") as? String ?? "",
                                                    zipcode: userData?.value(forKey:"zipcode") as? String ?? "",
                                                    language: userData?.value(forKey:"language") as? String ?? "",
                                                    experience: userData?.value(forKey:"experience") as? String ?? "",
                                                    education_level: userData?.value(forKey:"education_level") as? String ?? "",
                                                    organization_id: userData?.value(forKey:"organization_id") as? String ?? "",
                                                    organization_name: userData?.value(forKey:"organization_name") as? String ?? "")
                
                
                
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return  nil
    }
    
    
    func writeUserCatalog(userCataLogData:UserCatalogModel)  {
        let managedContext = context
        
        let existingEntity = NSEntityDescription.entity(forEntityName: TableName.userCatalog.rawValue, in: managedContext)
       
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.userCatalog.rawValue)
        let filterPredicate = NSPredicate(format: "name == %@", userCataLogData.name)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            if fetchedObjects.count > 0 {
                var managedObject = fetchedObjects[0]
                managedObject.setValue(userCataLogData.name, forKey: "name")
                managedObject.setValue(userCataLogData.country, forKey: "country")
                managedObject.setValue(userCataLogData.region_state, forKey: "region_state")
                managedObject.setValue(userCataLogData.city, forKey: "city")
                managedObject.setValue(userCataLogData.workplace, forKey: "workplace")
                managedObject.setValue(userCataLogData.profession, forKey: "profession")
                managedObject.setValue(userCataLogData.zipcode, forKey: "zipcode")
                managedObject.setValue(userCataLogData.language, forKey: "language")
                managedObject.setValue(userCataLogData.experience, forKey: "experience")
                managedObject.setValue(userCataLogData.education_level, forKey: "education_level")
                managedObject.setValue(userCataLogData.organization_id, forKey: "organization_id")
                managedObject.setValue(userCataLogData.organization_name, forKey: "organization_name")
            }else {
                let managedObject = NSManagedObject(entity: existingEntity!, insertInto: managedContext)
                managedObject.setValue(userCataLogData.name, forKey: "name")
                managedObject.setValue(userCataLogData.country, forKey: "country")
                managedObject.setValue(userCataLogData.region_state, forKey: "region_state")
                managedObject.setValue(userCataLogData.city, forKey: "city")
                managedObject.setValue(userCataLogData.workplace, forKey: "workplace")
                managedObject.setValue(userCataLogData.profession, forKey: "profession")
                managedObject.setValue(userCataLogData.zipcode, forKey: "zipcode")
                managedObject.setValue(userCataLogData.language, forKey: "language")
                managedObject.setValue(userCataLogData.experience, forKey: "experience")
                managedObject.setValue(userCataLogData.education_level, forKey: "education_level")
                managedObject.setValue(userCataLogData.organization_id, forKey: "organization_id")
                managedObject.setValue(userCataLogData.organization_name, forKey: "organization_name")
                }
            try managedContext.save()
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        
        
        
        // Set properties of the Core Data entity based on ExceptionDataObject properties
       
        
        // Add additional properties as needed
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
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
    
    func writeCoreCatalogData(subject:CatalogSubject,data:Data) {
        let managedContext = context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.catalogEvents.rawValue)
        let filterPredicate = NSPredicate(format: "subject == %@", subject.rawValue)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            if fetchedObjects.count > 0 {
                let oldData = fetchedObjects.first?.value(forKey: "catalog")
                let newData = self.getCorecatalogTypeData(newData:data, oldData: oldData as! Data, subject:subject)
                let managedObejct = fetchedObjects[0]
                managedObejct.setValue(subject.rawValue, forKey:"subject")
                managedObejct.setValue(newData, forKey:"catalog")
            }else {
                let entity = NSEntityDescription.entity(forEntityName: TableName.catalogEvents.rawValue, in: managedContext)!
                let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
                managedObject.setValue(subject.rawValue, forKey: "subject")
                managedObject.setValue(data, forKey:"catalog")
                }
            try managedContext.save()
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
    
   public func readCataLogData(subject:String) -> Data? {
        var data:Data = Data()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.catalogEvents.rawValue)
        let filterPredicate = NSPredicate(format: "subject == %@", subject)
        fetchRequest.predicate = filterPredicate
        do {
            let resultData = try context.fetch(fetchRequest)
            if resultData.count > 0 {
                if let castedData = resultData.first!.value(forKey: "catalog") as? Data {
                   data = castedData
                } else {
                   
                }
                }else {
               
            }
            } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return data
    }
    
    
    func deleteDataEventLogs(){
    // Create a fetch request to get all records from the entity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.userEvents.rawValue)

        do {
            // Fetch all records
            let records = try context.fetch(fetchRequest)

            // Delete each record
            for record in records {
                context.delete(record)
            }

            // Save the changes
            try context.save()
        } catch {
            print("Error deleting all records: \(error)")
        }
    }
    
   
}


extension Encodable {
    public func toData(using encoder: JSONEncoder = JSONEncoder()) -> Data? {
        do {
            return try encoder.encode(self)
        } catch {
            print("Error encoding data: \(error)")
            return nil
        }
    }
}
