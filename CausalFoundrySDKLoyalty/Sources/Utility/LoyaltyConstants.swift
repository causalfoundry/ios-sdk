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

    static func isItemTypeObjectValid(itemValue: PromoItemObject, eventType: LoyaltyEventType) {
        let eventName = eventType.rawValue

        if itemValue.item_id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_id")
            return
        } else if itemValue.item_type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_type")
            return
        } else if !CoreConstants.shared.enumContains(PromoItemType.self, name: itemValue.item_type) {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "ItemType")
            return
        }
    }
    
    static func isSurveyObjectValid(surveyObject: SurveyObject, eventType: LoyaltyEventType) -> Bool {
        let eventName = eventType.rawValue

        if surveyObject.id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "survey_id")
            return false
        } else if surveyObject.type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "survey_type")
            return false
        } else if !CoreConstants.shared.enumContains(SurveyType.self, name: surveyObject.type) {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "survey_type")
            return false
        }
        return true
    }
    
    static func isSurveyResponseListValid(responseList: [SurveyResponseItem], eventType: LoyaltyEventType) -> Bool {
        
        for item in responseList {
            if !CoreConstants.shared.enumContains(SurveyType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: SurveyType.self))
                return false
            } else if item.id.isEmpty {
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
        } else if !CoreConstants.shared.enumContains(RedeemType.self, name: redeemObject.type) {
            ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: RedeemType.self))
            return false
        } else if redeemObject.convertedValue! < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "converted_value")
            return false
        } else if redeemObject.isSuccessful == nil {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "redeem is_successful")
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

    static func verifyCatalogForSurvey(surveyId: String, surveyCatalogModel: SurveyCatalogModel) -> InternalSurveyModel? {
        let catalogName = CatalogSubject.survey.rawValue + " catalog"

        if surveyId.isEmpty {
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
            return InternalSurveyModel(
                id: surveyId,
                name: CoreConstants.shared.checkIfNull(surveyCatalogModel.name),
                duration: surveyCatalogModel.duration,
                type: CoreConstants.shared.checkIfNull(surveyCatalogModel.type),
                reward_id: CoreConstants.shared.checkIfNull(surveyCatalogModel.reward_id),
                questions_list: surveyCatalogModel.questions_list,
                description: CoreConstants.shared.checkIfNull(surveyCatalogModel.description),
                creation_date: getTimeConvertedToString(eventTime: Int64(surveyCatalogModel.creation_date)),
                expiry_date: getTimeConvertedToString(eventTime: Int64(surveyCatalogModel.expiry_date)), 
                organization_id: CoreConstants.shared.checkIfNull(surveyCatalogModel.organization_id),
                organization_name: CoreConstants.shared.checkIfNull(surveyCatalogModel.organization_name)
            )
        }
    }

    static func verifyCatalogForReward(rewardId: String, rewardCatalogModel: RewardCatalogModel) -> InternalRewardModel? {
        let catalogName = CatalogSubject.reward.rawValue + " catalog"

        if rewardId.isEmpty {
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
            return InternalRewardModel(
                id: rewardId,
                name: CoreConstants.shared.checkIfNull(rewardCatalogModel.name),
                description: CoreConstants.shared.checkIfNull(rewardCatalogModel.description),
                type: CoreConstants.shared.checkIfNull(rewardCatalogModel.type),
                requiredPoints: rewardCatalogModel.requiredPoints,
                creationDate: getTimeConvertedToString(eventTime: rewardCatalogModel.creationDate),
                expiryDate: getTimeConvertedToString(eventTime: rewardCatalogModel.expiryDate),
                organizationId: CoreConstants.shared.checkIfNull(rewardCatalogModel.organizationId),
                organizationName: CoreConstants.shared.checkIfNull(rewardCatalogModel.organizationName)
            )
        }
    }

    static func getDateTime(milliSeconds: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = Date(timeIntervalSince1970: TimeInterval(milliSeconds) / 1000)
        return dateFormatter.string(from: date)
    }

    private static func getTimeConvertedToString(eventTime: Int64) -> String {
        if eventTime != 0 {
            return getDateTime(milliSeconds: eventTime)
        } else {
            return ""
        }
    }
}
