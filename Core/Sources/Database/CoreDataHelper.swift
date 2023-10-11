//
//  File.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation
import CoreData

public class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    public init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "paperdb")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Context
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
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
    
    
    func writeExceptionEvents(eventArray: [ExceptionDataObject]) {
        
        let managedContext = context
        
        for exceptionDataObject in eventArray {
            let entity = NSEntityDescription.entity(forEntityName: "ExceptionDataEntity", in: managedContext)!
            let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
            
            // Set properties of the Core Data entity based on ExceptionDataObject properties
            managedObject.setValue(exceptionDataObject.title, forKey: "title")
            managedObject.setValue(exceptionDataObject.eventType, forKey: "eventType")
            managedObject.setValue(exceptionDataObject.exceptionType, forKey: "exceptionType")
            managedObject.setValue(exceptionDataObject.exceptionSource, forKey: "exceptionSource")
            managedObject.setValue(exceptionDataObject.stackTrace, forKey: "stackTrace")
            managedObject.setValue(exceptionDataObject.ts, forKey: "ts")
            
            // Add additional properties as needed
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    func writeUser(user: String,deviceID:String) {
        
        let managedContext = context
        let entity = NSEntityDescription.entity(forEntityName: "userDataEntity", in: managedContext)!
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
    
    
    func getUserID() {
        
    }
    
    
    
    // MARK: - Insert
    
    func insertData(name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "YourEntityName", in: context)!
        let newItem = NSManagedObject(entity: entity, insertInto: context)
        newItem.setValue(name, forKey: "name")
        
        saveContext()
    }
    
    // MARK: - Update
    
    func updateData(item: NSManagedObject, newName: String) {
        item.setValue(newName, forKey: "name")
        saveContext()
    }
    
    // MARK: - Delete
    
    func deleteData(item: NSManagedObject) {
        context.delete(item)
        saveContext()
    }
    
    // MARK: - Fetch
    
    
    
    func fetchUserID(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "userDataEntity")
        do {
            let items = try context.fetch(fetchRequest)
            print(items)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
    
}
