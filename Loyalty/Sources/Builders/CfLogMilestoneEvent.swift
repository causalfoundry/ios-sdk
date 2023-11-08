//
//  CfLogMilestoneEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation


import Foundation

public class CfLogMilestoneEvent {
    
    /**
     * CfLogMilestoneEvent is to log actions regarding milestones which can be when the user
     * achieved a milestone.
     */
    var milestone_id: String?
    var action_value: String?
    private var meta: Any?
    private var update_immediately: Bool = CoreConstants.updateImmediately
    
    
    /**
     * setMilestoneId is required for logging the milestone user achieved. The is should be in
     * a string format and must in accordance to the catalog provided.
     */
    
    
    @discardableResult
    public func setMilestoneId(_ milestone_id: String?) -> CfLogMilestoneEvent {
        self.milestone_id = milestone_id
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
    public func setAction(_ action: MilestoneAction) -> CfLogMilestoneEvent {
        self.action_value = action.rawValue
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
    public func setAction(_ action: String?) -> CfLogMilestoneEvent {
        if let action = action {
            if CoreConstants.shared.enumContains(MilestoneAction.self, rawValue: action) {
                self.action_value = action
            } else {
                ExceptionManager.throwEnumException(
                    LoyaltyEventType.milestone.rawValue,
                    String(describing: MilestoneAction.self))
            }
        } else {
            self.action_value = action
        }
        
        return self
        
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogMilestoneEvent {
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
    public func updateImmediately(_ update_immediately: Bool) -> CfLogMilestoneEvent {
        self.update_immediately = update_immediately
        return self
    }
    
    /**
     * build will validate all of the values provided and if passes will call the track
     *
     @discardableResult
     public function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    
    @discardableResult
    public func build() {
        /**
         * Will throw and exception if the milestone_id provided is null or no value is
         * provided at all.
         */
        
        if milestone_id?.isEmpty {
            ExceptionManager.throwIsRequiredException(
                LoyaltyEventType.milestone.rawValue,
                "milestone_id"
            )
            return
            /**
             * Will throw and exception if the action provided is null or no value is
             * provided at all.
             */
        }else if action_value?.isEmpty {
            ExceptionManager.throwIsRequiredException(
                LoyaltyEventType.milestone.rawValue,
                MilestoneAction.self.simpleClassName()
            )
            return
        }else {
            /**
             * Parsing the values into an object and passing to the setup block to queue
             * the event based on its priority.
             */
            let milestoneObject = MilestoneObject(
                milestone_id: milestone_id,
                action_value: action_value,
                meta: meta
            )
            CFSetup().track(
                LoyaltyConstants.contentBlockName,
                LoyaltyEventType.milestone.rawValue,
                milestoneObject,
                update_immediately
            )
        }
    }
}


