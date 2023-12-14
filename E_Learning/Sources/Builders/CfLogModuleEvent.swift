//
//  CfLogModuleEvent.swift
//
//
//  Created by khushbu on 02/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogModuleEvent {
    /**
     * CfLogModuleEvent is required to log actions related to e-learning modules which includes
     * the log for user viewing the module, starting and finishing the module and also user
     * viewing the content page as well.
     */
    var moduleId: String?
    var progress: Int?
    var action: String?
    private var meta: Any?
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setModuleId is required to log moduleId for the module being opened by the user.
     * module Id should be in a string format and must be in accordance to the catalog
     * provided.
     */

    @discardableResult
    public func setModuleId(_ moduleId: String) -> CfLogModuleEvent {
        self.moduleId = moduleId
        return self
    }

    /**
     * setModuleProgress is required to pass current progress of the module which the user is
     * viewing. Progress value is the percentage complete for the module that needs to passed
     * as an integer.
     */
    @discardableResult
    public func setModuleProgress(_ progress: Int?) -> CfLogModuleEvent {
        self.progress = progress
        return self
    } /**
     * setModuleAction is required to set the Action type for the module event. SDK provides
     * enum classes to support available log types. 1 main is view.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the function to log type using enum.
     */

    @discardableResult
    public func setModuleAction(_ action: ModuleLogAction) -> CfLogModuleEvent {
        self.action = action.rawValue
        return self
    }

    /**
     * setModuleAction is required to set the Action type for the module event. SDK provides
     * enum classes to support available log types. 1 main is view.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the function to log type using string. Remember to note that
     * values provided using string should be the same as provided in enum or else the
     * events will be discarded.
     */
    @discardableResult
    public func setModuleAction(_ action: String?) -> CfLogModuleEvent {
        if let action = action {
            if CoreConstants.shared.enumContains(ModuleLogAction.self, name: action) {
                self.action = action
            } else {
                ExceptionManager.throwEnumException(eventType: ELearnEventType.module.rawValue, className: String(describing: ModuleLogAction.self))
            }
        } else {
            self.action = action
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogModuleEvent {
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
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogModuleEvent {
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
         * Will throw and exception if the moduleId provided is null or no value is
         * provided at all.
         */
        guard let moduleId = moduleId else {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.module.rawValue, elementName: "module_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no value is
         * provided at all.
         */

        guard let action = action else {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.module.rawValue, elementName: String(String(describing: ModuleLogAction.self)))
            return
        }
        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */
        let moduleObject = ModuleObject(id: moduleId, progress: progress, action: action, meta: meta as? Encodable)
        CFSetup().track(
            contentBlockName: ELearningConstants.contentBlockName,
            eventType: ELearnEventType.module.rawValue,
            logObject: moduleObject,
            updateImmediately: updateImmediately
        )
    }
}
