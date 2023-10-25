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
        userDataEntity.name = TableName.user.rawValue
        
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
        exceptionDataEntity.name = TableName.exceptionData.rawValue // Set the entity name
        
        
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
        
        
        
        
        // Create a UserCatalog Table
        let userCatalogEntity = NSEntityDescription()
        userCatalogEntity.name = TableName.userCatalog.rawValue
        
        // Create attributes
        let attributedUserName = NSAttributeDescription()
        attributedUserName.name = "name"
        attributedUserName.attributeType = .stringAttributeType
        
        let attributedCountry = NSAttributeDescription()
        attributedCountry.name = "country"
        attributedCountry.attributeType = .stringAttributeType
        
        let attributedRegion = NSAttributeDescription()
        attributedRegion.name = "region_state"
        attributedRegion.attributeType = .stringAttributeType
        
        let attributedCity = NSAttributeDescription()
        attributedCity.name = "city"
        attributedCity.attributeType = .stringAttributeType
        
        let attributedWorkPlace = NSAttributeDescription()
        attributedWorkPlace.name = "workplace"
        attributedWorkPlace.attributeType = .stringAttributeType
        
        let attributedProfession = NSAttributeDescription()
        attributedProfession.name = "profession"
        attributedProfession.attributeType = .stringAttributeType
        
        let attributedZipCode = NSAttributeDescription()
        attributedZipCode.name = "zipcode"
        attributedZipCode.attributeType = .stringAttributeType
        
        let attributedLanguage = NSAttributeDescription()
        attributedLanguage.name = "language"
        attributedLanguage.attributeType = .stringAttributeType
        
        let attributedexperience = NSAttributeDescription()
        attributedexperience.name = "experience"
        attributedexperience.attributeType = .stringAttributeType
        
        let attributeEducation = NSAttributeDescription()
        attributeEducation.name = "education_level"
        attributeEducation.attributeType = .stringAttributeType
        
        let attributeOrganizationID = NSAttributeDescription()
        attributeOrganizationID.name = "organization_id"
        attributeOrganizationID.attributeType = .stringAttributeType
        
        let attributeOrganizationName = NSAttributeDescription()
        attributeOrganizationName.name = "organization_name"
        attributeOrganizationName.attributeType = .stringAttributeType
        
        userCatalogEntity.properties = [attributedUserName,attributedCountry,attributedRegion, attributedCity, attributedWorkPlace, attributedProfession, attributedZipCode, attributedLanguage,attributedexperience,attributeEducation, attributeOrganizationID, attributeOrganizationName ]
        
        // Create a managed object model
        let managedObjectModel = NSManagedObjectModel()
        managedObjectModel.entities = [userDataEntity,exceptionDataEntity,userCatalogEntity]
        
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
        let managedObject = NSManagedObject(entity: existingEntity!, insertInto: managedContext)
       
            // Set properties of the Core Data entity based on ExceptionDataObject properties
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
            
            // Add additional properties as needed
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
