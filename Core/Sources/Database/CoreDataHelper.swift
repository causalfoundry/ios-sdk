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
        
        if persistentContainer == nil {
            let model = createManagedObjectModel()
            // Specify the file path where you want to save the model
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let modelURL = documentsDirectory.appendingPathComponent("_causulFoundry.xcdatamodeld")
            saveManagedObjectModelToFile(model: model, filePath: modelURL)
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
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
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
    // GET ALL EXCEPTION LOGS
    func getStoredExceptionsData() -> [ExceptionDataObject]{
        var itemData:[ExceptionDataObject]? = []
        if let existingEntity = NSEntityDescription.entity(forEntityName: "ExceptionData", in: context) {
            var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExceptionData")
            do {
                let items = try context.fetch(fetchRequest)
                itemData = items as? [ExceptionDataObject]
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                
            }
        }else {
            
            
        }
        return itemData!
    }
    
    func createExceptionEntity() {
        let newEntity = NSEntityDescription()
        let managedContext = context
        
        newEntity.name = "ExceptionData" // Set the entity name
        
        let managedObjectModel = NSManagedObjectModel()
        managedObjectModel.entities = [newEntity]
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let modelURL = documentsDirectory.appendingPathComponent("_causulFoundry.xcdatamodeld")
        saveManagedObjectModelToFile(model: managedObjectModel, filePath: modelURL)
        
        self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "title", attributeType: .stringAttributeType, context: managedContext)
        self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "eventType", attributeType: .stringAttributeType, context: managedContext)
        
        self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "exceptionType", attributeType: .stringAttributeType, context: managedContext)
        
        self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "exceptionSource", attributeType: .stringAttributeType, context: managedContext)
        
        self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "stackTrace", attributeType: .stringAttributeType, context: managedContext)
        self.addAttributeToEntity(entityName:  newEntity.name!, attributeName: "ts", attributeType: .stringAttributeType, context: managedContext)
        
    }
    
    func writeExceptionEvents(eventArray: [ExceptionDataObject]) {
        let managedContext = context
        
        if NSEntityDescription.entity(forEntityName: "ExceptionData", in: context) == nil  {
            self.createExceptionEntity()
        }
        var existingEntity = NSEntityDescription.entity(forEntityName: "ExceptionData", in: context)
        for exceptionDataObject in eventArray {
            
            let managedObject = NSManagedObject(entity: existingEntity!, insertInto: managedContext)
            
            
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
    
    
    // MARK: - Fetch User ID
    func fetchUserID(deviceID:String = "") -> String {
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "deviceID == %@", deviceID)
        do {
            let items = try context.fetch(fetchRequest)
            var user = items.first?.value(forKey: "userID")
            print(items)
            return user as! String
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return ""
    }
}


