//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation
import CausalFoundrySDKCore

internal class CFLoyaltySetupInterfaceImpl: CFLoyaltySetupInterface {
    
    
    // Singleton instance
    static let shared = CFLoyaltySetupInterfaceImpl()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    
    func trackSDKEvent<T: Codable>(eventType: LoyaltyEventType,
                                   logObject: T?,
                                   isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                   eventTime: Int64? = 0) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        validateLoyaltyEvent(eventType: eventType, logObject: logObject, isUpdateImmediately: isUpdateImmediately, eventTime: eventTime)
        
    }
    
    func trackCatalogEvent(catalogType: LoyaltyCatalogType, catalogModel: Any) {
        if CoreConstants.shared.pauseSDK{
            return
        }
        CfLoyaltyCatalog.callCatalogAPI(catalogType: catalogType, catalogModel: catalogModel)
    }
    
    private func validateLoyaltyEvent<T: Codable>(eventType: LoyaltyEventType, logObject: T?, isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                                  eventTime: Int64? = 0) {
        switch eventType {
        case .Level:
            if let eventObject = LoyaltyEventValidator.validateLevelEvent(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: nil,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Milestone:
            if let eventObject = LoyaltyEventValidator.validateMilestoneEvent(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Promo:
            if let eventObject = LoyaltyEventValidator.validatePromoEvent(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.promoAction,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Reward:
            if let eventObject = LoyaltyEventValidator.validateRewardEvent(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.rewardAction,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Survey:
            if let eventObject = LoyaltyEventValidator.validateSurveyEvent(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        }
    }
}

