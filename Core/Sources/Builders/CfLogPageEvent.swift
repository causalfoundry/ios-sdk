//
//  CfLogPageEvent.swift
//
//
//  Created by khushbu on 05/10/23.
//

import Foundation

public class CfLogPageEvent {
    var path_value: String?
    var title_value: String?
    var duration_value: Float?
    var render_time_value: Int = 0
    var content_block: String = CoreConstants.shared.contentBlockName
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
}

public class CfLogPageBuilder {
    var path_value: String?
    var title_value: String?
    var duration_value: Float?
    var render_time_value: Int?
    var content_block: String = CoreConstants.shared.contentBlockName
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately

    /**
     * setPath is required to log the package details for the activity/screen/page to know
     * the full context of the activity user is spending the time on.
     */
    public func setPath(path: String) -> CfLogPageBuilder {
        path_value = path
        return self
    }

    /**
     * setTitle is required to set the title or class name of the activity/screen/page
     * to know the context the user is spending the time on.
     */
    public func setTitle(title: String) -> CfLogPageBuilder {
        title_value = title
        return self
    }

    /**
     * setDuration is required to log the amount of time user is spending on that screen
     * to compute the required KPIs in order to define the right metrics.
     */
    public func setDuration(duration: Float) -> CfLogPageBuilder {
        duration_value = Float((duration * 100.0).rounded() / 100.0)
        return self
    }

    /**
     * setRenderTime is required to log the amount of time it is required by the page to load.
     */
    public func setRenderTime(render_time: Int) -> CfLogPageBuilder {
        render_time_value = render_time
        return self
    }

    /*** setContentBlock is used to specify the type of module the page is in.
     * page can be in any multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlock to log the module, you can also use string function as
     * well in order to log the content block. Below is the function for the usage of enum type
     * function.
     */
    public func setContentBlock(content_block: ContentBlock) -> CfLogPageBuilder {
        self.content_block = content_block.rawValue
        return self
    }

    /**
     * setContentBlock is used to specify the type of module the page is in.
     * page can be in any multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlock to log the module, you can also use string function as
     * well in order to log the content block. Below is the function for the usage of string type
     * function. Remember to note that you need to use the same enum types as provided by the
     * enums or else the events will be discarded.
     */
    public func setContentBlock(content_block: String) -> CfLogPageBuilder {
        if ContentBlock.allCases.filter({ $0.rawValue == content_block }).first != nil {
            self.content_block = content_block
        } else {
            ExceptionManager.throwEnumException(
                eventType: CoreEventType.page.rawValue,
                className: String(String(describing: CfLogPageEvent.self))
            )
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    public func setMeta(meta: Any?) -> CfLogPageBuilder {
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
    public func updateImmediately(update_immediately: Bool) -> CfLogPageBuilder {
        self.update_immediately = update_immediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the path provided is null or no value is
         * provided at all.
         */

        if path_value == nil {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "path_value")
            return
        }else if title_value == nil {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "title")
            return
        }else if duration_value == nil {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "duration")
            return
        }else if render_time_value == nil {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "render_time_value")
            return
        }else if duration_value! < 0 {
            ExceptionManager.throwInvalidException(eventType: CoreEventType.page.rawValue,
                                                   paramName: "duration_value", className: String(describing: CfLogPageEvent.self))
            return
        }

        if render_time_value! > 10000 {
            render_time_value = 0
        }
        
        let pageObject = PageObject(path: path_value, title: title_value, duration: duration_value, render_time: render_time_value, meta: meta as? Encodable)

        CFSetup().track(contentBlockName: CoreConstants.shared.contentBlockName, eventType: CoreEventType.page.rawValue, logObject: pageObject, updateImmediately: update_immediately, eventTime: 0)
    }
}
