//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import KenkaiSDKCore
import Foundation

public class LoyaltyEventValidator {
    
    static func validateLevelEvent<T: Codable>(logObject: T?) -> LevelObject? {
        guard let eventObject = logObject as? LevelObject else {
            ExceptionManager.throwInvalidException(
                eventType: LoyaltyEventType.Level.rawValue,
                paramName: "LevelObject",
                className: "LevelObject"
            )
            return nil
        }
        
        if(eventObject.prevLevel < 0){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Level.rawValue, elementName: "previous_level")
            return nil
        }
        
        if(eventObject.newLevel < 0){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Level.rawValue, elementName: "new_level")
            return nil
        }
        
        return eventObject
    }
    
    static func validateMilestoneEvent<T: Codable>(logObject: T?) -> MilestoneObject? {
        guard let eventObject = logObject as? MilestoneObject else {
            ExceptionManager.throwInvalidException(
                eventType: LoyaltyEventType.Milestone.rawValue,
                paramName: "MilestoneObject",
                className: "MilestoneObject"
            )
            return nil
        }
        
        if(eventObject.id.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Milestone.rawValue, elementName: "milestone_id")
            return nil
        } else if !CoreConstants.shared.enumContains(MilestoneAction.self, name: eventObject.action) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Milestone.rawValue, className: "milestone action")
            return nil
        }
        
        return eventObject
    }
    
    
    static func validatePromoEvent<T: Codable>(logObject: T?) -> PromoObject? {
        guard let eventObject = logObject as? PromoObject else {
            ExceptionManager.throwInvalidException(
                eventType: LoyaltyEventType.Promo.rawValue,
                paramName: "PromoObject",
                className: "PromoObject"
            )
            return nil
        }
        
        if(eventObject.promoId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Promo.rawValue, elementName: "promo_id")
            return nil
        }else if !CoreConstants.shared.enumContains(PromoAction.self, name: eventObject.promoAction) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Promo.rawValue, className: "promo action")
            return nil
        }else if !CoreConstants.shared.enumContains(PromoType.self, name: eventObject.promoType) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Promo.rawValue, className: "promo type")
            return nil
        }
        
        for item in eventObject.promoItemsList {
            if(item.isEmpty){
                ExceptionManager.throwInvalidException(eventType: LoyaltyEventType.Promo.rawValue, paramName: "promo item id", className: "promoItemsList")
                return nil
            }
        }
        return eventObject
    }
    
    static func validateSurveyEvent<T: Codable>(logObject: T?) -> SurveyEventObject? {
        guard let eventObject = logObject as? SurveyEventObject else {
            ExceptionManager.throwInvalidException(
                eventType: LoyaltyEventType.Survey.rawValue,
                paramName: "SurveyEventObject",
                className: "SurveyEventObject"
            )
            return nil
        }
        
        if !CoreConstants.shared.enumContains(SurveyAction.self, name: eventObject.action) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Survey.rawValue, className: "survey action")
            return nil
        }else if(eventObject.action == SurveyAction.Submit.rawValue && eventObject.responseList.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Survey.rawValue, elementName: "response_list")
            return nil
        }else if(eventObject.surveyId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Survey.rawValue, elementName: "survey id")
            return nil
        }else if !CoreConstants.shared.enumContains(SurveyType.self, name: eventObject.surveyType) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Survey.rawValue, className: "survey type")
            return nil
        }
        return eventObject
    }
    
    static func validateRewardEvent<T: Codable>(logObject: T?) -> RewardEventObject? {
        guard let eventObject = logObject as? RewardEventObject else {
            ExceptionManager.throwInvalidException(
                eventType: LoyaltyEventType.Reward.rawValue,
                paramName: "RewardEventObject",
                className: "RewardEventObject"
            )
            return nil
        }
        
        if(eventObject.rewardId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Reward.rawValue, elementName: "reward_id")
            return nil
        }else if !CoreConstants.shared.enumContains(RewardAction.self, name: eventObject.rewardAction) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Promo.rawValue, className: "reward action")
            return nil
        }else if(eventObject.rewardAction == RewardAction.Add.rawValue && eventObject.accPoints == 0){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Reward.rawValue, elementName: "acc_points")
            return nil
        }else if(eventObject.totalPoints == nil){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Reward.rawValue, elementName: "total_points")
            return nil
        }else if(eventObject.rewardAction == RewardAction.Redeem.rawValue && eventObject.redeemPointsWithdrawn! < 0){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Reward.rawValue, elementName: "redeem points withdrawn")
            return nil
        }else if(eventObject.rewardAction == RewardAction.Redeem.rawValue && eventObject.redeemIsSuccessful == nil){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Reward.rawValue, elementName: "redeem is_successful")
            return nil
        }else if !CoreConstants.shared.enumContains(RewardAction.self, name: eventObject.rewardAction) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Promo.rawValue, className: "reward action")
            return nil
        }else if eventObject.redeemType == RedeemType.Cash.rawValue, eventObject.redeemCurrency == nil {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Promo.rawValue, elementName: "redeem currency")
            return nil
        } else if eventObject.redeemType == RedeemType.Cash.rawValue, !CoreConstants.shared.enumContains(CurrencyCode.self, name: eventObject.redeemCurrency!) {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.Promo.rawValue, className: String(describing: CurrencyCode.self))
            return nil
        }
    
        return eventObject
    }
    
}
