//
//  CfLogRewardEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogRewardEvent {
    /**
     * CfLogRewardEvent is to log the reward related events for user, which includes viewing,
     * redeeming, adding.
     */
    private var rewardId: String = ""
    private var actionValue: String = ""
    private var accPoints: Float = 0
    private var totalPoints: Float = 0
    private var redeemObject: RedeemObject?
    private var meta: Any?
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setRewardId is for the providing Id for the reward event. Can be userId if the
     * reward is not redeemed individually.
     */
    @discardableResult
    public func setRewardId(rewardId: String) -> CfLogRewardEvent {
        self.rewardId = rewardId
        return self
    }

    /**
     * setAction is required to set the Action type for the Reward Action. SDK provides
     * enum classes to support available log types. 1 main is achieved.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type.
     */
    @discardableResult
    public func setAction(action: RewardAction) -> CfLogRewardEvent {
        actionValue = action.rawValue
        return self
    }

    @discardableResult
    public func setAction(action: String) -> CfLogRewardEvent {
        if CoreConstants.shared.enumContains(RewardAction.self, name: action) {
            actionValue = action
        } else {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.reward.rawValue, className: String(describing: RewardAction.self))
        }
        return self
    }

    /**
     * setAccumulatedPoints is for the providing achieved points in case of add reward event.
     */
    @discardableResult
    public func setAccumulatedPoints(accPoints: Float) -> CfLogRewardEvent {
        self.accPoints = accPoints
        return self
    }

    /**
     * setTotalPoints logs the total points achieved so far by the user.
     */
    @discardableResult
    public func setTotalPoints(totalPoints: Float) -> CfLogRewardEvent {
        self.totalPoints = totalPoints
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
    public func setRedeemObject(redeemObject: RedeemObject) -> CfLogRewardEvent {
        self.redeemObject = redeemObject
        return self
    }

    // Set Redeem Object from JSON String
    @discardableResult
    public func setRedeemObject(redeemObject: String) -> CfLogRewardEvent {
        if let redeemData = redeemObject.data(using: .utf8),
           let redeemObj = try? JSONDecoder.new.decode(RedeemObject.self, from: redeemData)
        {
            setRedeemObject(redeemObject: redeemObj)
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any) -> CfLogRewardEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogRewardEvent {
        self.updateImmediately = updateImmediately
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
        if rewardId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.reward.rawValue, elementName: "reward_id")
            return
        }else if actionValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.reward.rawValue, elementName: "action_value")
            return
        }else if actionValue == RewardAction.add.rawValue, accPoints == 0 {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.reward.rawValue, elementName: "acc_points")
            return
        }else if actionValue == RewardAction.redeem.rawValue, redeemObject == nil {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.reward.rawValue, elementName: "redeem_object")
            return
        } else if actionValue == RewardAction.redeem.rawValue, !LoyaltyConstants.isRedeemObjectValid(redeemObject: redeemObject!, eventType: LoyaltyEventType.reward) {
            return
        } else if actionValue != RewardAction.redeem.rawValue {
            redeemObject = nil
        }

        // Create a RewardEventObject
        let rewardEventObject = RewardEventObject(
            rewardId: rewardId,
            action: actionValue,
            accPoints: accPoints,
            totalPoints: totalPoints,
            redeem: redeemObject,
            meta: meta as? Encodable
        )
        CFSetup().track(contentBlockName: LoyaltyConstants.contentBlockName, eventType: LoyaltyEventType.reward.rawValue, logObject: rewardEventObject, updateImmediately: updateImmediately)
    }
}
