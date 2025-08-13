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
    
    
    func trackSDKEvent<T: Codable>(
        eventName: CoreEventType,
        logObject: T?,
        isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
        eventTime: Int64? = 0) {
            
            if CoreConstants.shared.pauseSDK {
                return
            }
        
            validateCoreEvent(eventName: eventName, logObject: logObject, isUpdateImmediately: isUpdateImmediately, eventTime: eventTime)
            
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
        case .Site:
            switch catalogObject {
            case let catalogObject as SiteCatalogModel:
                CfCoreCatalog.updateSiteCatalog(siteCatalogModel: catalogObject)
            case let catalogObject as String:
                CfCoreCatalog.updateSiteCatalogString(siteCatalogString: catalogObject)
            default:
                ExceptionManager.throwInvalidException(
                    eventType: "Site Catalog", paramName: "SiteCatalogModel", className: String(describing: SiteCatalogModel.self)
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
    
    private func validateCoreEvent<T: Codable>(eventName: CoreEventType, logObject: T?, isUpdateImmediately: Bool?, eventTime: Int64?) {
        switch eventName {
        case .App:
            let logobj = CoreEventValidator.validateAppObject(logObject: logObject)
            CFSetup().track(
                eventName: CoreEventType.App.rawValue,
                eventProperty: logobj?.action,
                eventCtx: logobj,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
        
        case .Page:
            let logobj = CoreEventValidator.validatePageObject(logObject: logObject)
            CFSetup().track(
                eventName: CoreEventType.Page.rawValue,
                eventProperty: logobj?.title,
                eventCtx: logobj,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
            
        case .Identify:
            let logobj =  CoreEventValidator.validateIdentifyObject(logObject: logObject)
            CFSetup().track(
                eventName: CoreEventType.Identify.rawValue,
                eventProperty: logobj?.action,
                eventCtx: logobj,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
            
        case .Media:
            let logobj =  CoreEventValidator.validateMediaObject(logObject: logObject)
            CFSetup().track(
                eventName: CoreEventType.Media.rawValue,
                eventProperty: logobj?.mediaType,
                eventCtx: logobj,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
            
        case .Rate:
            let logobj =  CoreEventValidator.validateRateObject(logObject: logObject)
            CFSetup().track(
                eventName: CoreEventType.Rate.rawValue,
                eventProperty: logobj?.type,
                eventCtx: logobj,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
            
        case .Search:
            let logobj =  CoreEventValidator.validateSearchObject(logObject: logObject)
            CFSetup().track(
                eventName: CoreEventType.Search.rawValue,
                eventProperty: logobj?.query,
                eventCtx: logobj,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
            
        case .ModuleSelection:
            let logobj =  CoreEventValidator.validateModuleSelectionObject(logObject: logObject)
            CFSetup().track(
                eventName: CoreEventType.ModuleSelection.rawValue,
                eventProperty: logobj?.type,
                eventCtx: logobj,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
            
        case .Track:
            if let logobj = CoreEventValidator.validateTrackObject(logObject: logObject) {
                CFSetup().track(
                    eventName: logobj.name, // already a String
                    eventProperty: logobj.property,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
            
        case .ActionResponse:
            if let logobj = CoreEventValidator.validateActionResponseObject(logObject: logObject) {
                CFSetup().track(
                    eventName:CoreEventType.ActionResponse.rawValue,
                    eventProperty: logobj.response,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        }
        
    }
}
