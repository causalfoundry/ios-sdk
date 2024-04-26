//
//  CfLogChwModuleEvent.swift
//
//
//  Created by khushbu on 25/10/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogChwModuleEvent {
    var moduleType: String?
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init(moduleType: String? = nil, meta: Any? = nil, updateImmediately: Bool) {
        self.moduleType = moduleType
        self.meta = meta
        self.updateImmediately = updateImmediately
    }
    /**
     * CfLogChwModuleEvent is required to log events related to selection of modules in a
     * chw management app screen. You can select the module type with the log values.
     */
}

public class CfLogChwModuleEventBuilder {
    public var moduleType: String?
    public var meta: Any?
    public var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setChwModuleEvent is for the providing the current module selected by the
     * user in the chw mgmt section on the main screen. You can use the default enum
     * provided in the SDK and can also use the string. Below is the function with
     * an enum as param.
     */
    @discardableResult
    public func setChwModuleEvent(patientModuleType: PatientModuleType) -> CfLogChwModuleEventBuilder {
        moduleType = patientModuleType.rawValue
        return self
    }

    /**
     * setChwModuleEvent is for the providing the current module selected by the
     * user in the chw mgmt section on the main screen. You can use the default enum
     * provided in the SDK and can also use the string. Below is the function with
     * an string as param.
     */
    @discardableResult
    public func setChwModuleEvent(patientModuleType: String) -> CfLogChwModuleEventBuilder {
        if CoreConstants.shared.enumContains(PatientModuleType.self, name: patientModuleType) {
            moduleType = patientModuleType
        } else {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.module_selection.rawValue, className: "PatientModuleType")
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogChwModuleEventBuilder {
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
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogChwModuleEventBuilder {
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
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        guard let moduleType = moduleType, !moduleType.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.module_selection.rawValue, elementName: "PatientModuleType")
            return
        }

        if !CoreConstants.shared.enumContains(PatientModuleType.self, name: self.moduleType!) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.module_selection.rawValue, className: "PatientModuleType")
            return
        }

        let chwModelObject = ChwModelObject(type: moduleType, meta: meta)
        CFSetup().track(contentBlockName: ChwConstants.contentBlockName, eventType: PatientMgmtEventType.module_selection.rawValue, logObject: chwModelObject, updateImmediately: updateImmediately)
    }
}
