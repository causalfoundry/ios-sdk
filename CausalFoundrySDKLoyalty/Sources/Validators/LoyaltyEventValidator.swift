//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
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
        }
        
        for item in eventObject.promoItemsList {
            if(!LoyaltyConstants.isItemTypeObjectValid(itemValue: item, eventType: LoyaltyEventType.Promo)){
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
        
        if(eventObject.action == SurveyAction.Submit.rawValue && eventObject.responseList.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Survey.rawValue, elementName: "response_list")
            return nil
        }else if(eventObject.survey.id.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Survey.rawValue, elementName: "survey id")
            return nil
        }else if(!LoyaltyConstants.isSurveyResponseListValid(responseList: eventObject.responseList, eventType: .Survey)){
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
        }else if(eventObject.action == RewardAction.Add.rawValue && eventObject.accPoints == 0){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Reward.rawValue, elementName: "acc_points")
            return nil
        }else if(eventObject.action == RewardAction.Redeem.rawValue && eventObject.redeem == nil){
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.Reward.rawValue, elementName: "redeem object")
            return nil
        }else if(eventObject.action == RewardAction.Redeem.rawValue && !LoyaltyConstants.isRedeemObjectValid(redeemObject: eventObject.redeem!, eventType: .Reward)){
            return nil
        }
    
        return eventObject
    }
    
}
