//
//  CoreDataHelper.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation
import CoreData

public class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    public init() {
        let model = NSManagedObjectModel()
        var filePath = Bundle.main.url(forResource: "file", withExtension: "txt")
        
        // Save the model to a file
        guard let modelURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("_CausulFoundry.xcdatamodel") else {
            fatalError("Unable to create model URL")
        }
        
        guard let compiledURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("MyModel.momd") else {
            fatalError("Unable to create compiled model URL")
        }
        
        //        guard NSManagedObjectModel.mergedModel(from: [model]) != nil else {
        //            fatalError("Unable to merge the models")
        //        }
        
        guard NSManagedObjectModel.mergedModel(from: nil) != nil else {
            fatalError("Unable to compile the model")
        }
        
        do {
           // try model.write(to:modelURL )
            print("Model saved to: \(modelURL)")
            
            // Move the model to a location where Xcode can compile it
            try FileManager.default.copyItem(at: modelURL, to: compiledURL)
            print("Model compiled to: \(compiledURL)")
        } catch {
            fatalError("Failed to save or compile the model: \(error)")
        }
    }
    
    
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "_CausulFoundry")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
        
    }
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
            
            if let existingEntity = NSEntityDescription.entity(forEntityName: "ExceptionDataEntity", in: context) {
                for exceptionDataObject in eventArray {
                    
                    let managedObject = NSManagedObject(entity: existingEntity, insertInto: managedContext)
                    
                    
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
            }else{
                let newEntity = NSEntityDescription()
                newEntity.name = "ExceptionDataEntity" // Set the entity name
                self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "title", attributeType: .stringAttributeType, context: managedContext)
                self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "eventType", attributeType: .stringAttributeType, context: managedContext)
                
                self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "exceptionType", attributeType: .stringAttributeType, context: managedContext)
                
                self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "exceptionSource", attributeType: .stringAttributeType, context: managedContext)
                
                self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "stackTrace", attributeType: .stringAttributeType, context: managedContext)
                self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "ts", attributeType: .stringAttributeType, context: managedContext)
                
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
            
        }
        func addAttributeToEntity(entityName: String, attributeName: String, attributeType: NSAttributeType, context: NSManagedObjectContext) {
            guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
                print("Entity not found: \(entityName)")
                return
            }
            
            let newAttribute = NSAttributeDescription()
            newAttribute.name = attributeName
            newAttribute.attributeType = attributeType // Set the attribute type (e.g., .stringAttributeType, .integer16AttributeType, etc.)
            // Add any other properties or configurations you need for the attribute
            
            // Add the new attribute to the entity
            entity.properties.append(newAttribute)
            
            // Save the managed object context to persist the changes
            do {
                try context.save()
                print("Attribute '\(attributeName)' added to entity '\(entityName)' successfully.")
            } catch {
                print("Failed to save context: \(error)")
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
    

