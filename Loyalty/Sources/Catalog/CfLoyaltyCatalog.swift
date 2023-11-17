//
//  CfLoyaltyCatalog.swift
//
//
//  Created by khushbu on 16/11/23.
//

import Foundation
import CasualFoundryCore


public class CfLoyaltyCatalog {

    // MARK: - Survey Catalog

    public static func updateSurveyCatalog(surveyId: String, surveyCatalogModel: String) {
        updateSurveyCatalog(surveyId: surveyId, surveyCatalogModel: try! JSONDecoder().decode(SurveyCatalogModel.self, from: surveyCatalogModel.data(using: .utf8)!))
    }

    public static func updateSurveyCatalog(surveyId: String, surveyCatalogModel: SurveyCatalogModel) {
        let surveyCatalogObject = LoyaltyConstants.verifyCatalogForSurvey(surveyId: surveyId, surveyCatalogModel: surveyCatalogModel)
        CFSetup().updateLoyaltyCatalogItem(subject:.survey, catalogObject: [surveyCatalogObject].toData()!)
    }

    // MARK: - Reward Catalog

    public static func updateRewardCatalog(rewardId: String, rewardCatalogModel: String) {
        updateRewardCatalog(rewardId: rewardId, rewardCatalogModel: try! JSONDecoder().decode(RewardCatalogModel.self, from: rewardCatalogModel.data(using: .utf8)!))
    }

    public static func updateRewardCatalog(rewardId: String, rewardCatalogModel: RewardCatalogModel) {
        let rewardCatalogObject = LoyaltyConstants.verifyCatalogForReward(rewardId: rewardId, rewardCatalogModel: rewardCatalogModel)
        CFSetup().updateLoyaltyCatalogItem(subject: .reward, catalogObject:[rewardCatalogObject].toData()!)
    }
}
