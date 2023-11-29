//
//  CfLogRewardEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation
import CasualFoundryCore

public class CfLogRewardEvent {
    /**
     * CfLogRewardEvent is to log the reward related events for user, which includes viewing,
     * redeeming, adding.
     */
    var reward_id: String?
    var action_value: String?
    var acc_points: Float?
    var total_points: Float?
    var redeem_object: RedeemObject?
    var usd_rate: Float?
    var isCashEvent: Bool = false
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    public init() {
        
    }
    
    /**
     * setRewardId is for the providing Id for the reward event. Can be userId if the
     * reward is not redeemed individually.
     */
    @discardableResult
    public func  setRewardId(_ reward_id: String) -> CfLogRewardEvent {
        self.reward_id = reward_id
        return self
    }
    
    /**
     * setAction is required to set the Action type for the Reward Action. SDK provides
     * enum classes to support available log types. 1 main is achieved.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type.
     */
    @discardableResult
    public func  setAction(_ action: RewardAction) -> CfLogRewardEvent {
        self.action_value = action.rawValue
        return self
    }
    
    /**
     * setAccumulatedPoints is for the providing achieved points in case of add reward event.
     */
    @discardableResult
    public func  setAccumulatedPoints(_ acc_points: Float) -> CfLogRewardEvent {
        self.acc_points = acc_points
        return self
    }
    
    /**
     * setTotalPoints logs the total points achieved so far by the user.
     */
    @discardableResult
    public func  setTotalPoints(_ total_points: Float) -> CfLogRewardEvent {
        self.total_points = total_points
        return self
    }
    
    
    /**
     * setRedeemObject is for the providing details about reward redeeming.
     * The object should be based on the RedeemObject or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the  @discardableResult
     public func tion for providing item as a string.
     */
    @discardableResult
    public func  setRedeemObject(_ redeem_object: RedeemObject) -> CfLogRewardEvent {
        self.redeem_object = redeem_object
        return self
    }
    
    // Set Redeem Object from JSON String
    @discardableResult
    public func  setRedeemObject(_ redeem_object: String) -> CfLogRewardEvent {
        if let redeemData = redeem_object.data(using: .utf8),
           let redeemObject = try? JSONDecoder().decode(RedeemObject.self, from: redeemData) {
            self.redeem_object = redeemObject
        }
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func  setMeta(_ meta: Any) -> CfLogRewardEvent {
        self.meta = meta
        return self
    }
    
    /**
     * updateImmediately is responsible for updating the values ot the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialisation block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait till the end of user
     * session which is whenever the app goes into background.
     */
    @discardableResult
    public func  updateImmediately(_ update_immediately: Bool) -> CfLogRewardEvent {
        self.update_immediately = update_immediately
        return self
    }
    
    
    /**
     * build will validate all of the values provided and if passes will call the track
     *  @discardableResult
     public func tion and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the reward_id provided is null or no value is
         * provided at all.
         */
        guard let reward_id = reward_id else {
            ExceptionManager.throwIsRequiredException(eventType:  LoyaltyEventType.reward.rawValue, elementName:"reward_id")
            return
        }
        /**
         * Will throw and exception if the action_value provided is null or no value is
         * provided at all.
         */
        guard let action_value = action_value else {
            ExceptionManager.throwIsRequiredException(eventType:  LoyaltyEventType.reward.rawValue, elementName:"action_value")
            return
        }
        
        /**
         * Will throw and exception if the acc_points provided is null or no value is
         * provided at all in-case of add action.
         */
        if action_value == RewardAction.add.rawValue && (acc_points == nil || acc_points == 0) {
            ExceptionManager.throwIsRequiredException(eventType:  LoyaltyEventType.reward.rawValue, elementName:"acc_points")
            return
        }
        
        /**
         * Will throw and exception if the total_points provided is null or no value is
         * provided at all.
         */
        guard let total_points = total_points else {
            ExceptionManager.throwIsRequiredException(eventType:  LoyaltyEventType.reward.rawValue, elementName:"total_points")
            return
        }
        
        /**
         * Will throw and exception if the action_value provided is null or no value is
         * provided at all.
         */
        
        if action_value == RewardAction.redeem.rawValue, redeem_object == nil {
            ExceptionManager.throwIsRequiredException(eventType:  LoyaltyEventType.reward.rawValue, elementName:"action_value")
            return
        } else if action_value == RewardAction.redeem.rawValue, let redeemObject = redeem_object {
            acc_points = nil
            
            if redeemObject.points_withdrawn < 0 {
                ExceptionManager.throwIsRequiredException(eventType:  LoyaltyEventType.reward.rawValue, elementName:"points_withdrawn")
                return
            } else if !CoreConstants.shared.enumContains(RedeemType.self, name: redeem_object!.type) {
                ExceptionManager.throwEnumException(eventType:  LoyaltyEventType.reward.rawValue, className:String(describing: RedeemType.self))
                return
            } else if redeemObject.converted_value! < 0 {
                ExceptionManager.throwIsRequiredException(eventType:LoyaltyEventType.reward.rawValue, elementName:"converted_value")
                return
            } else if redeemObject.is_successful == nil {
                ExceptionManager.throwIsRequiredException(eventType:LoyaltyEventType.reward.rawValue, elementName:"redeem is_successful")
                return
            } else if redeemObject.type == RedeemType.cash.rawValue {
                if redeemObject.currency == nil {
                    ExceptionManager.throwIsRequiredException(eventType:  LoyaltyEventType.reward.rawValue, elementName:"redeem currency")
                    return
                } else if !CoreConstants.shared.enumContains(CurrencyCode.self, name: redeem_object!.currency!){
                    ExceptionManager.throwEnumException(eventType:  LoyaltyEventType.reward.rawValue, className:String(describing: CurrencyCode.self))
                    return
                } else {
                    isCashEvent = true
                }
            } else {
                redeem_object?.currency = nil
            }
        } else {
            redeem_object = nil
            isCashEvent = false
        }
        
        // Create a RewardEventObject
        var rewardEventObject = RewardEventObject(
            rewardId: reward_id,
            action: action_value,
            accPoints: acc_points,
            totalPoints: total_points,
            redeem: redeem_object,
            usdRate: usd_rate,
            meta: meta as? Encodable
        )
        
        if isCashEvent {
            if let currency = rewardEventObject.redeem?.currency, currency == InternalCurrencyCode.USD.rawValue {
                rewardEventObject.usdRate = 1.0
                callEventTrack(rewardEventObject)
            } else {
                
                CFSetup().getUSDRate(fromCurrency:  rewardEventObject.redeem?.currency ?? "") { value in
                    self.callEventTrack(RewardEventObject(rewardId: reward_id, action: reward_id, accPoints:  self.acc_points, totalPoints: total_points, redeem: self.redeem_object, usdRate: self.usd_rate, meta: self.meta as? Encodable))
                    return value
                }
               
            }
        } else {
            callEventTrack(rewardEventObject)
        }
    }
    
    
    public func  callEventTrack(_ rewardEventObject: RewardEventObject) {
       CFSetup().track(contentBlockName: LoyaltyConstants.contentBlockName, eventType: LoyaltyEventType.reward.rawValue, logObject: rewardEventObject, updateImmediately: update_immediately)
    }
    
}
