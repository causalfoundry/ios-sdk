//
//  File.swift
//
//
//  Created by khushbu on 05/10/23.
//

import Foundation

public class CfLogPageEvent {
    var path_value: String? = nil
    var title_value: String? = nil
    var duration_value: Float? = nil
    var render_time_value: Int = 0
    var content_block: String = CoreConstants.shared.contentBlockName
    var meta: Any? = nil
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
}

public class CfLogPageBuilder {
    private var path_value: String? = nil
    private var title_value: String? = nil
    private var duration_value: Float? = nil
    private var render_time_value: Int? = nil
    private var content_block: String = CoreConstants.shared.contentBlockName
    private var meta: Any?
    private var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    /**
     * setPath is required to log the package details for the activity/screen/page to know
     * the full context of the activity user is spending the time on.
     */
    public func setPath(path: String) -> CfLogPageBuilder {
        self.path_value = path
        return self
    }
    /**
     * setTitle is required to set the title or class name of the activity/screen/page
     * to know the context the user is spending the time on.
     */
    public func setTitle(title: String) -> CfLogPageBuilder {
        self.title_value = title
        return self
    }
    
    /**
     * setDuration is required to log the amount of time user is spending on that screen
     * to compute the required KPIs in order to define the right metrics.
     */
    public func setDuration(duration: Float) -> CfLogPageBuilder {
        self.duration_value = Float((duration * 100.0).rounded() / 100.0)
        return self
    }
    /**
     * setRenderTime is required to log the amount of time it is required by the page to load.
     */
    public func setRenderTime(render_time: Int) -> CfLogPageBuilder {
        self.render_time_value = render_time
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
        if (ContentBlock.allValues.filter({$0.rawValue == content_block}).first != nil) {
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
    public func setMeta(meta: Any?)  -> CfLogPageBuilder {
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
    public func build () {
        /**
         * Will throw and exception if the path provided is null or no value is
         * provided at all.
         */
        
        while(self.path_value == nil ) {
            
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "path_value")
        }
        /**
         * Will throw and exception if the title provided is null or no value is
         * provided at all.
         */
        while(self.title_value == nil ) {
            
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "title")
        }
        /**
         * Will throw and exception if the duration provided is null or no value is
         * provided at all.
         */
        while(self.duration_value == nil ) {
            
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "duration")
        }
        
        /**
         * Will throw and exception if the render_time_value provided is below 0
         */
        while(self.render_time_value == nil ) {
            
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.page.rawValue, elementName: "render_time_value")
        }
        /**
         * Will throw and exception if the render_time_value provided is more than 10000 - 10 sec
         */
        if self.render_time_value! > 1000 {
            ExceptionManager.throwInvalidException(eventType: CoreEventType.page.rawValue,
                                                     paramName: "render_time"
            )
        }
        
        var pageObject = PageObject(path: self.path_value, title: self.title_value, duration: self.duration_value, render_time: self.render_time_value, meta: self.meta)
        if pageObject.render_time! > 1000 {
            pageObject.render_time = 0
        }
        
        CFSetup().track(contentBlockName: CoreConstants.shared.contentBlockName, eventType: CoreEventType.page.rawValue, logObject: pageObject, updateImmediately: update_immediately, eventTime:0)
        
    }
}