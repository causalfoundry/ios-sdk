//
//  CfLogMilestoneEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogMilestoneEvent {
    /**
     * CfLogMilestoneEvent is to log actions regarding milestones which can be when the user
     * achieved a milestone.
     */
    private var milestone_id: String = ""
    private var action_value: String = ""
    private var meta: Any?
    private var update_immediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setMilestoneId is required for logging the milestone user achieved. The is should be in
     * a string format and must in accordance to the catalog provided.
     */

    @discardableResult
    public func setMilestoneId(milestoneId: String?) -> CfLogMilestoneEvent {
        self.milestone_id = milestoneId!
        return self
    }

    /**
     * setAction is required to set the Action type for the Milestone event. SDK provides
     * enum classes to support available log types. 1 main is achieved.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the
     @discardableResult
     public function to log type using enum.
     */

    @discardableResult
    public func setAction(action: MilestoneAction) -> CfLogMilestoneEvent {
        action_value = action.rawValue
        return self
    }

    /**
     * setAction is required to set the Action type for the Milestone event. SDK provides
     * enum classes to support available log types. 1 main is achieved.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the
     @discardableResult
     public function to log type using string. Remember to note that
     * values provided using string should be the same as provided in enum or else the
     * events will be discarded.
     */

    @discardableResult
    public func setAction(action: String?) -> CfLogMilestoneEvent {
        if let action = action {
            if CoreConstants.shared.enumContains(MilestoneAction.self, name: action) {
                action_value = action
            } else {
                ExceptionManager.throwEnumException(
                    eventType: LoyaltyEventType.milestone.rawValue,
                    className: String(describing: MilestoneAction.self)
                )
            }
        } else {
            action_value = action!
        }

        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogMilestoneEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogMilestoneEvent {
        self.update_immediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     *
     @discardableResult
     public function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        /**
         * Will throw and exception if the milestone_id provided is null or no value is
         * provided at all.
         */

        if milestone_id.isEmpty {
            ExceptionManager.throwIsRequiredException(
                eventType: LoyaltyEventType.milestone.rawValue,
                elementName: "milestone_id"
            )
            return

        } else if action_value.isEmpty {
            /**
             * Will throw and exception if the action provided is null or no value is
             * provided at all.
             */
            ExceptionManager.throwIsRequiredException(
                eventType: LoyaltyEventType.milestone.rawValue,
                elementName: String(describing: MilestoneAction.self)
            )
            return
        } else {
            /**
             * Parsing the values into an object and passing to the setup block to queue
             * the event based on its priority.
             */
            let milestoneObject = MilestoneObject(
                id: milestone_id,
                action: action_value,
                meta: meta as? Encodable
            )
            CFSetup().track(
                contentBlockName: LoyaltyConstants.contentBlockName,
                eventType: LoyaltyEventType.milestone.rawValue,
                logObject: milestoneObject,
                updateImmediately: update_immediately
            )
        }
    }
}
