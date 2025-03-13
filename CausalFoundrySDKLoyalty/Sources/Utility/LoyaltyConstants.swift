//
//  LoyaltyConstants.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

enum LoyaltyConstants {
    static let contentBlockName = "loyalty"

    static func isItemTypeObjectValid(itemValue: PromoItemObject, eventType: LoyaltyEventType) -> Bool {
        let eventName = eventType.rawValue

        if itemValue.itemId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_id")
            return false
        }
        return true
    }
    
    static func isSurveyResponseListValid(responseList: [SurveyResponseItem], eventType: LoyaltyEventType) -> Bool {
        
        for item in responseList {
            if item.id.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "response_question_id")
                return false
            } else if item.question.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "response_question_text")
                return false
            }
        }
        return true
    }
    
    static func isRedeemObjectValid(redeemObject: RedeemObject, eventType: LoyaltyEventType) -> Bool {
        if redeemObject.pointsWithdrawn < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "points_withdrawn")
            return false
        } else if redeemObject.convertedValue < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "converted_value")
            return false
        } else if redeemObject.type == RedeemType.Cash.rawValue, redeemObject.currency == nil {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "redeem currency")
            return false
        } else if redeemObject.type == RedeemType.Cash.rawValue, !CoreConstants.shared.enumContains(CurrencyCode.self, name: redeemObject.currency!) {
            ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: CurrencyCode.self))
            return false
        }
        return true
    }

    static func verifyCatalogForSurvey(surveyCatalogModel: SurveyCatalogModel) -> SurveyCatalogModel? {
        let catalogName = CatalogSubject.survey.rawValue + " catalog"

        if surveyCatalogModel.id.isEmpty {
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

    static func verifyCatalogForReward(rewardCatalogModel: RewardCatalogModel) -> RewardCatalogModel? {
        let catalogName = CatalogSubject.reward.rawValue + " catalog"

        if rewardCatalogModel.id.isEmpty {
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
