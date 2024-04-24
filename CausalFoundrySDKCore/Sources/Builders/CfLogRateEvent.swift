//
//  CfLogRateEvent.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation

public class CfLogRateEvent {
    var rateValue: Float
    var type: String
    var subjectId: String
    var contentBlock: String
    var meta: Any?
    var updateImmediately: Bool?

    init(rateValue: Float, type: String, subjectId: String, contentBlock: String = ContentBlock.Core.rawValue, meta: Any? = nil, updateImmediately _: Bool) {
        self.rateValue = rateValue
        self.type = type
        self.subjectId = subjectId
        self.contentBlock = contentBlock
        self.meta = meta
        updateImmediately = CoreConstants.shared.updateImmediately
    }
}

public class CfLogRateEventBuilder {
    var rateValue: Float = 0.0
    var type: String = ""
    var subjectId: String = ""
    var contentBlock: String = ""
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setContentBlock is used to specify the type of module the rate is applied to.
     * rate can be used for multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlockType to log the module, you can also use string function as
     * well in order to log the content block type. Below is the function for the usage of enum
     * type function.
     */
    @discardableResult
    public func setContentBlock(contentBlock: ContentBlock) -> CfLogRateEventBuilder {
        self.contentBlock = contentBlock.rawValue
        return self
    }

    /**
     * setContentBlock is used to specify the type of module the rate is applied to.
     * rate can be used for multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlockType to log the module, you can also use string function as
     * well in order to log the content block type. Below is the function for the usage of
     * content block type function. Remember to note that you need to use the same enum types
     * as provided by the enums or else the events will be discarded.
     */
    @discardableResult
    public func setContentBlock(contentBlock: String) -> CfLogRateEventBuilder {
        if CoreConstants.shared.enumContains(ContentBlock.self, name: contentBlock) {
            self.contentBlock = contentBlock
        } else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.Rate.rawValue, className: String(describing: ContentBlock.self))
        }
        return self
    }

    /**
     * setRateValue is for the providing the value for the rate. Should be in between 0 to 5,
     * if there are more elements like 0 to 10, make sure to divide the value by 2.
     */
    @discardableResult
    public func setRateValue(rateValue: Float) -> CfLogRateEventBuilder {
        self.rateValue = rateValue
        return self
    }

    /**
     * setRateType is for the providing the type of the element being rated. By default SDK
     * provides enum values for the rate type to log the events base don specific types but
     * you can also use string values as well. Below is the function for logging rate type
     * using string.Remember to use the same strings as provided in the enums or else the
     * event will be discarded.
     */
    @discardableResult
    public func setRateType(type: RateType) -> CfLogRateEventBuilder {
        self.type = type.rawValue
        return self
    }

    @discardableResult
    public func setRateType(type: String) -> CfLogRateEventBuilder {
        if CoreConstants.shared.enumContains(RateType.self, name: type) {
            self.type = type
        } else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.Rate.rawValue, className: String(describing: RateType.self))
        }
        return self
    }

    /**
     * setSubjectId is required to set the subject Id for the item being rated. It is required
     * in all cases, if the app is rated then provide the application id
     */
    @discardableResult
    public func setSubjectId(subjectId: String) -> CfLogRateEventBuilder {
        self.subjectId = subjectId
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogRateEventBuilder {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogRateEventBuilder {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        if rateValue < 0 || rateValue > 5 {
            ExceptionManager.throwIllegalStateException(eventType: CoreEventType.Rate.rawValue, message: "Rate Value should be 0 to 5 (both inclusive)", className: String(describing: CfLogRateEvent.self))
            return
        }else if type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Rate.rawValue, elementName: "\(RateType.self)")
            return
        }else if subjectId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Rate.rawValue, elementName: "subject_id")
            return
        }

        let rateObject = RateObject(rate_value: rateValue, type: type, subject_id: subjectId, meta: meta as? Encodable)
        CFSetup().track(contentBlockName: contentBlock, eventType: CoreEventType.Rate.rawValue, logObject: rateObject, updateImmediately: updateImmediately)
    }
}
