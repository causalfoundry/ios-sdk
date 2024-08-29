//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

internal class CFCoreSetupInterfaceImpl: CFCoreSetupInterface {
    
    
    // Singleton instance
        static let shared = CFCoreSetupInterfaceImpl()
        
        // Private initializer to prevent external instantiation
        private init() {}
    
    
    func trackSDKEvent<T: Codable>(eventType: CoreEventType,
                       logObject: T?,
                       contentBlock: ContentBlock? = CoreConstants.shared.contentBlock,
                       isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                       eventTime: Int64? = 0) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        
       
        if let eventObject = validateCoreEvent(eventType: eventType, logObject: logObject){
            CFSetup().track(
                contentBlockName: contentBlock?.rawValue ?? ContentBlock.Core.rawValue,
                eventType: eventType.rawValue,
                logObject: eventObject,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
        }else{
            print("Unknown event object type")
        }
    }

    func trackCatalogEvent(coreCatalogType: CoreCatalogSubject, catalogModel: Any) {
        if CoreConstants.shared.pauseSDK{
            return
        }
        validateCoreCatalogEvent(coreCatalogType: coreCatalogType, catalogObject: catalogModel)
    }

    private func validateCoreCatalogEvent(coreCatalogType: CoreCatalogSubject, catalogObject: Any) {
        switch coreCatalogType {
        case .User:
            switch catalogObject {
            case let userCatalogModel as UserCatalogModel:
                CfCoreCatalog.updateUserCatalogData(userCatalogModel: userCatalogModel)
            case let catalogString as String:
                CfCoreCatalog.updateUserCatalog(userCatalogModelString: catalogString)
            default:
                ExceptionManager.throwInvalidException(
                    eventType: "User Catalog", paramName: "UserCatalogModel", className: String(describing: UserCatalogModel.self)
                )
            }
        case .Media:
            switch catalogObject {
            case let mediaCatalogModel as MediaCatalogModel:
                CfCoreCatalog.updateMediaCatalogData(mediaCatalogModel: mediaCatalogModel)
            case let catalogString as String:
                CfCoreCatalog.updateMediaCatalog(mediaCatalogModelString: catalogString)
            default:
                ExceptionManager.throwInvalidException(
                    eventType: "Media Catalog", paramName: "MediaCatalogModel", className: String(describing: MediaCatalogModel.self)
                )
            }
        }
    }

    private func validateCoreEvent<T: Codable>(eventType: CoreEventType, logObject: T?) -> T? {
        switch eventType {
        case .App:
            return AppEventValidator.validateAppObject(logObject: logObject) as? T
        case .Page:
            return PageEventValidator.validatePageObject(logObject: logObject) as? T
        case .Identify:
            return IdentifyEventValidator.validateIdentifyObject(logObject: logObject) as? T
        case .Media:
            return MediaEventValidator.validateMediaObject(logObject: logObject) as? T
        case .Rate:
            return RateEventValidator.validateRateObject(logObject: logObject) as? T
//        case .Search:
//            return SearchEventValidator.validateSearchObject(logObject: logObject)
        default:
            print("Unknown event or object type")
            return logObject
        }
    }
}
