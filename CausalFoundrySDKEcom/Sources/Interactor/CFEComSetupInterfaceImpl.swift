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
        
        validateEComEvent(eventType: eventType, logObject: logObject, isUpdateImmediately: isUpdateImmediately, eventTime: eventTime)
    }
    
    func trackCatalogEvent<T: Codable>(eComCatalogType: EComCatalogType, subjectId: String, catalogModel: T) {
        guard !CoreConstants.shared.pauseSDK else { return }

        print("trackCatalogEvent called")
        var subject: CatalogSubject? = nil
        var catalogData: Codable? = nil

        switch eComCatalogType {
        case .Drug:
            if let model = catalogModel as? DrugCatalogModel {
                subject = .drug
                catalogData = ECommerceConstants.verifyCatalogForDrug(subjectId: subjectId, drugCatalogModel: model)
            }
        case .Grocery:
            if let model = catalogModel as? GroceryCatalogModel {
                subject = .grocery
                catalogData = ECommerceConstants.verifyCatalogForGrocery(subjectId: subjectId, groceryCatalogModel: model)
            }
        case .Blood:
            if let model = catalogModel as? BloodCatalogModel {
                subject = .blood
                catalogData = ECommerceConstants.verifyCatalogForBlood(subjectId: subjectId, bloodCatalogModel: model)
            }
        case .Oxygen:
            if let model = catalogModel as? OxygenCatalogModel {
                subject = .oxygen
                catalogData = ECommerceConstants.verifyCatalogForOxygen(subjectId: subjectId, oxygenCatalogModel: model)
            }
        case .MedicalEquipment:
            if let model = catalogModel as? MedicalEquipmentCatalogModel {
                subject = .medical_equipment
                catalogData = ECommerceConstants.verifyCatalogForMedicalEquipment(subjectId: subjectId, medicalEquipmentCatalogModel: model)
            }
        case .Facility:
            if let model = catalogModel as? FacilityCatalogModel {
                subject = .facility
                catalogData = ECommerceConstants.verifyCatalogForFacility(subjectId: subjectId, facilityCatalogModel: model)
            }
        }

        if let subject = subject, let catalogData = catalogData {
            CFSetup().updateCatalogItem(subject: subject, subjectId: subjectId, catalogObject: catalogData)
        } else {
            ExceptionManager.throwIllegalStateException(
                eventType: "Ecommerce catalog",
                message: "Please use correct catalog properties with provided item type",
                className: "CfEComCatalog"
            )
        }
    }

    
    
    private func validateEComEvent<T: Codable>(eventType: EComEventType, logObject: T?, isUpdateImmediately: Bool?, eventTime: Int64?) {
        switch eventType {
        case .Item:
            if let logobj = EcomEventValidator.validateViewItemEvent(logObject: logObject) {
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: logobj.action,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Cart:
            if let logobj = EcomEventValidator.validateCartEvent(logObject: logObject) {
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: logobj.action,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Checkout:
            if let checkoutList = EcomEventValidator.validateCheckoutEvent(logObject: logObject) {
                checkoutList.forEach { order in
                    CFSetup().track(
                        eventName: eventType.rawValue, // assuming .checkout is an enum case
                        eventProperty: order.isSuccessful ? "success" : "failure",
                        eventCtx: order,
                        updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                        eventTime: eventTime ?? 0
                    )
                }
            }
        case .CancelCheckout:
            if let logobj = EcomEventValidator.validateCancelCheckoutEvent(logObject: logObject) {
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: logobj.type,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Delivery:
            if let logobj = EcomEventValidator.validateDeliveryEvent(logObject: logObject) {
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: logobj.action,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .ItemReport:
            if let logobj = EcomEventValidator.validateItemReportEvent(logObject: logObject) {
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: nil,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .ItemRequest:
            if let logobj = EcomEventValidator.validateItemRequestEvent(logObject: logObject) {
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: nil,
                    eventCtx: logobj,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        }
    }
}

