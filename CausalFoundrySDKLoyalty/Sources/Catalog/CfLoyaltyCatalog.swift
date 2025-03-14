//
//  CfLoyaltyCatalog.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

enum CfLoyaltyCatalog {
    
    static func callCatalogAPI(catalogType: LoyaltyCatalogType, catalogModel: Any){
        var propertiesDecoded = false
        switch(catalogType){
        case .Survey:
            if let catalog = catalogModel as? SurveyCatalogModel {
                let surveyCatalogObject = LoyaltyConstants.verifyCatalogForSurvey(surveyCatalogModel: catalog)
                CFSetup().updateLoyaltyCatalogItem(subject: .survey, catalogObject: [surveyCatalogObject].toData())
                propertiesDecoded = true
            }
        case .Reward:
            if let catalog = catalogModel as? RewardCatalogModel {
                let rewardCatalogObject = LoyaltyConstants.verifyCatalogForReward(rewardCatalogModel: catalog)
                CFSetup().updateLoyaltyCatalogItem(subject: .reward, catalogObject: [rewardCatalogObject].toData())
                propertiesDecoded = true
            }
        }
        
        if !propertiesDecoded {
            ExceptionManager.throwIllegalStateException(eventType: "loyalty catalog", message: "Please use correct catalog properties with provided catalog type", className: "CfLoyaltyCatalog")
        }
        
    }
    
}
