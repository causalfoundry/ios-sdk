//
//  CfLogLevelEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogLevelEvent {
    /**
     * CfLogLevelEvent is to log the update of user level. It required the user level before update and
     * user level after the update. You need to pass module Id as well if the level update event is
     * triggered because of the e-learning content block, any achievement in the e-learning platform.
     */
    var prevLevel: Int?
    var newLevel: Int?
    var moduleId: String?
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setPreviousLevel is required to set the previous score/level number for the user.
     */

    @discardableResult
    public func setPreviousLevel(prevLevel: Int?) -> CfLogLevelEvent {
        self.prevLevel = prevLevel
        return self
    }

    /**
     * setNewLevel is required to set the new score/level number for the user. This can be
     * from any source, e-learning or e-commerce or even social.
     */
    @discardableResult
    public func setNewLevel(newLevel: Int?) -> CfLogLevelEvent {
        self.newLevel = newLevel
        return self
    }

    /**
     * setModuleId is for specific use-case when update of level is from e-learning. In
     * such case module id is required, otherwise you can pass null for this as well.
     */

    @discardableResult
    public func setModuleId(moduleId: String?) -> CfLogLevelEvent {
        self.moduleId = moduleId
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogLevelEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogLevelEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        /**
         * Will throw and exception if the prev_level provided is null or no value is
         * provided at all.
         */
        guard prevLevel != nil else {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.level.rawValue, elementName: "previous_level")
            return
        }

        /**
         * Will throw and exception if the new_level provided is null or no value is
         * provided at all.
         */

        guard newLevel != nil else {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.level.rawValue, elementName: "new_level")
            return
        }

        let levelObject = LevelObject(prevLevel: prevLevel!, newLevel: newLevel!, moduleId: moduleId, meta: meta as? Encodable)

        CFSetup().track(contentBlockName: LoyaltyConstants.contentBlockName, eventType: LoyaltyEventType.level.rawValue, logObject: levelObject, updateImmediately: updateImmediately)
    }
}
