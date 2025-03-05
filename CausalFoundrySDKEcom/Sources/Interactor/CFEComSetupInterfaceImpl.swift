//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation
import CausalFoundrySDKCore

internal class CFEComSetupInterfaceImpl: CFEComSetupInterface {
    
    
    // Singleton instance
    static let shared = CFEComSetupInterfaceImpl()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    
    func trackSDKEvent<T: Codable>(eventType: EComEventType,
                                   logObject: T?,
                                   isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                   eventTime: Int64? = 0) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        
        
        if let eventObject = validateEComEvent(eventType: eventType, logObject: logObject){
            CFSetup().track(
                contentBlockName: ContentBlock.ECommerce.rawValue,
                eventType: eventType.rawValue,
                logObject: eventObject,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
        }else{
            print("Unknown event object type")
        }
    }
    
    func trackCatalogEvent(catalogType: EComCatalogType, catalogModel: Any) {
        if CoreConstants.shared.pauseSDK{
            return
        }
        validateCoreCatalogEvent(catalogType: catalogType, catalogObject: catalogModel)
    }
    
    private func validateCoreCatalogEvent(catalogType: EComCatalogType, catalogObject: Any) {
        switch catalogType {
        case .Drug:
            switch catalogObject {
            case let userCatalogModel as UserCatalogModel:
                CfCoreCatalog.updateUserCatalogData(userCatalogModel: userCatalogModel)
            default:
                ExceptionManager.throwInvalidException(
                    eventType: "User Catalog", paramName: "UserCatalogModel", className: String(describing: UserCatalogModel.self)
                )
            }
        case .Grocery:
            <#code#>
        case .Blood:
            <#code#>
        case .Oxygen:
            <#code#>
        case .MedicalEquipment:
            <#code#>
        case .Facility:
            <#code#>
        }
    }
    
    private func validateEComEvent<T: Codable>(eventType: EComEventType, logObject: T?) -> T? {
        switch eventType {
        case .Item:
            //            return AppEventValidator.validateAppObject(logObject: logObject) as? T
            return nil
        default:
            print("Unknown event or object type")
            return logObject
        }
    }
}

