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
        // Create an entity description
        let userDataEntity = NSEntityDescription()
        userDataEntity.name = "User"
        
        // Create attributes
        let attributeUser = NSAttributeDescription()
        attributeUser.name = "userID"
        attributeUser.attributeType = .stringAttributeType
        
        
        let attributeDeviceID = NSAttributeDescription()
        attributeDeviceID.name = "deviceID"
        attributeDeviceID.attributeType = .stringAttributeType
        
        // Add the attribute to the entity
        userDataEntity.properties = [attributeUser, attributeDeviceID]
        
        let exceptionDataEntity = NSEntityDescription()
        exceptionDataEntity.name = "ExceptionData" // Set the entity name
        
        
        // Create attributes
        
        let attributEventTitle = NSAttributeDescription()
        attributEventTitle.name = "title"
        attributEventTitle.attributeType = .stringAttributeType
        
        let attributEventType = NSAttributeDescription()
        attributEventType.name = "eventType"
        attributEventType.attributeType = .stringAttributeType
        
        
        let attributeExceptionType = NSAttributeDescription()
        attributeExceptionType.name = "exceptionType"
        attributeExceptionType.attributeType = .stringAttributeType
        
        let attributeExceptionSource = NSAttributeDescription()
        attributeExceptionSource.name = "exceptionSource"
        attributeExceptionSource.attributeType = .stringAttributeType
        
        let attributeDeviceTs = NSAttributeDescription()
        attributeDeviceTs.name = "ts"
        attributeDeviceTs.attributeType = .stringAttributeType
        
        let attributeStackTrace = NSAttributeDescription()
        attributeStackTrace.name = "stackTrace"
        attributeStackTrace.attributeType = .stringAttributeType
        
        // Add the attribute to the entity
        exceptionDataEntity.properties = [attributEventTitle, attributEventType,attributeExceptionType, attributeExceptionSource,attributeDeviceTs, attributeStackTrace  ]
        
        // Create a managed object model
        let managedObjectModel = NSManagedObjectModel()
        managedObjectModel.entities = [userDataEntity,exceptionDataEntity]
        
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
}




extension CoreDataHelper {
    // GET ALL EXCEPTION LOGS
    func getStoredExceptionsData() -> [ExceptionDataObject]{
        var itemData:[ExceptionDataObject]? = []
        if let existingEntity = NSEntityDescription.entity(forEntityName: "ExceptionData", in: context) {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: existingEntity.name!)
            do {
                let items = try context.fetch(fetchRequest)
                if items.count > 0 {
                    itemData =  items.map({ (data) in
                        var exceptionData = ExceptionDataObject(title: (data.value(forKey:"title") as? String ?? "" ) ,
                                                                eventType: data.value(forKey:"eventType") as? String  ?? "",
                                                                exceptionType: data.value(forKey:"exceptionType") as? String ?? "",
                                                                exceptionSource: data.value(forKey:"exceptionSource") as? String ?? "" ,
                                                                stackTrace: data.value(forKey:"stackTrace") as? String ?? "",
                                                                ts: data.value(forKey:"ts") as? String ??  "")
                        return exceptionData
                    })
                }
                itemData = items as? [ExceptionDataObject]
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
        
        let existingEntity = NSEntityDescription.entity(forEntityName: "ExceptionData", in: managedContext)
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
