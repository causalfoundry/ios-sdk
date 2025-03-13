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
        
        
        if let eventObject = validateLoyaltyEvent(eventType: eventType, logObject: logObject){
            CFSetup().track(
                contentBlockName: ContentBlock.Loyalty.rawValue,
                eventType: eventType.rawValue,
                logObject: eventObject,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
        }else{
            print("Unknown event object type")
        }
    }
    
    func trackCatalogEvent(catalogType: LoyaltyCatalogType, catalogModel: Any) {
        if CoreConstants.shared.pauseSDK{
            return
        }
        CfLoyaltyCatalog.callCatalogAPI(catalogType: catalogType, catalogModel: catalogModel)
    }
    
    private func validateLoyaltyEvent<T: Codable>(eventType: LoyaltyEventType, logObject: T?) -> T? {
        switch eventType {
        case .Level:
            return LoyaltyEventValidator.validateLevelEvent(logObject: logObject) as? T
        case .Milestone:
            return LoyaltyEventValidator.validateMilestoneEvent(logObject: logObject) as? T
        case .Promo:
            return LoyaltyEventValidator.validatePromoEvent(logObject: logObject) as? T
        case .Reward:
            return LoyaltyEventValidator.validateRewardEvent(logObject: logObject) as? T
        case .Survey:
            return LoyaltyEventValidator.validateSurveyEvent(logObject: logObject) as? T
        }
    }
}

