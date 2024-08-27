//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

internal class CFCoreSetupInterfaceImpl: CFCoreSetupInterface {
    
    func trackSDKEvent<T: Codable>(eventType: CoreEventType,
                       logObject: T?,
                       contentBlock: ContentBlock?,
                       isUpdateImmediately: Bool?,
                       eventTime: Int64?) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        
       
        CFSetup().track(
            contentBlockName: (contentBlock ?? .Core).rawValue,
            eventType: eventType.rawValue,
            logObject: validateCoreEvent(eventType: eventType, logObject: logObject),
            updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
            eventTime: eventTime ?? 0
        )
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
        return logObject
//        switch eventType {
//        case .App:
//            return AppEventValidator.validateAppObject(logObject: logObject)
//        case .Page:
//            return PageEventValidator.validatePageObject(logObject: logObject)
//        case .Identify:
//            return IdentifyEventValidator.validateIdentifyObject(logObject: logObject)
//        case .Media:
//            return MediaEventValidator.validateMediaObject(logObject: logObject)
//        case .Rate:
//            return RateEventValidator.validateRateObject(logObject: logObject)
//        case .Search:
//            return SearchEventValidator.validateSearchObject(logObject: logObject)
//        default:
//            print("Unknown event or object type")
//            return nil
//        }
    }
}
