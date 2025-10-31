//
//  LoyaltyConstants.swift
//
//
//  Created by khushbu on 07/11/23.
//

import KenkaiSDKCore
import Foundation

enum LoyaltyConstants {
    static let contentBlockName = "loyalty"

    static func verifyCatalogForSurvey(subjectId: String, surveyCatalogModel: SurveyCatalogModel) -> SurveyCatalogModel? {
        let catalogName = CatalogSubject.survey.rawValue + " catalog"

        if subjectId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "survey Id")
            return nil
        } else if surveyCatalogModel.name.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "survey name")
            return nil
        } else if surveyCatalogModel.type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "survey type")
            return nil
        } else if surveyCatalogModel.questions_list.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "survey questions")
            return nil
        } else {
            return surveyCatalogModel
        }
    }

    static func verifyCatalogForReward(subjectId: String, rewardCatalogModel: RewardCatalogModel) -> RewardCatalogModel? {
        let catalogName = CatalogSubject.reward.rawValue + " catalog"

        if subjectId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "reward Id")
            return nil
        } else if rewardCatalogModel.name.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "reward name")
            return nil
        } else if rewardCatalogModel.type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "reward type")
            return nil
        } else if rewardCatalogModel.requiredPoints < 1 {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "required_points")
            return nil
        } else {
            return rewardCatalogModel
        }
    }
}
