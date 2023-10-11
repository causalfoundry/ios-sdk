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
    
    static let shared = CoreDataHelper()
    
    public init() {
        let model = createManagedObjectModel()

        // Specify the file path where you want to save the model
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let modelURL = documentsDirectory.appendingPathComponent("_causulFoundry.xcdatamodeld")

        saveManagedObjectModelToFile(model: model, filePath: modelURL)
    }
    
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "_causulFoundry")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
        
    }
    
    func createManagedObjectModel() -> NSManagedObjectModel {
        // Create an entity description
        let entityDescription = NSEntityDescription()
        entityDescription.name = "User"
        
        // Create attributes
        let attributeUser = NSAttributeDescription()
        attributeUser.name = "userID"
        attributeUser.attributeType = .stringAttributeType
        
        
        let attributeDeviceID = NSAttributeDescription()
        
        attributeDeviceID.name = "deviceID"
        attributeDeviceID.attributeType = .stringAttributeType
        
        // Add the attribute to the entity
        entityDescription.properties = [attributeUser, attributeDeviceID]
        
        // Create a managed object model
        let managedObjectModel = NSManagedObjectModel()
        managedObjectModel.entities = [entityDescription]
        
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
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
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
    

