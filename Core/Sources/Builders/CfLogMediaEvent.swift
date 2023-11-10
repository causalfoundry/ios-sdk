//
//  CfLogMediaEvent.swift
//
//
//  Created by khushbu on 09/10/23.
//

import Foundation


public class CfLogMediaEvent {
    var media_id: String?
    var media_type: String?
    var media_action: String?
    var duration_value: Int?
    var content_block: String = CoreConstants.shared.contentBlockName
    var mediaModel_value: MediaCatalogModel?
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    
    init(media_id: String? = nil, media_type: String? = nil, media_action: String? = nil, duration_value: Int? = nil, content_block: String, mediaModel_value: MediaCatalogModel? = nil, meta: Any? = nil, update_immediately: Bool) {
        self.media_id = media_id
        self.media_type = media_type
        self.media_action = media_action
        self.duration_value = duration_value
        self.content_block = content_block
        self.mediaModel_value = mediaModel_value
        self.meta = meta
        self.update_immediately = update_immediately
    }
}


public class  CfLogMediaEventBuilder {
    var media_id: String?
    var media_type: String?
    var media_action: String?
    var duration_value: Int?
    var content_block: String = CoreConstants.shared.contentBlockName
    var mediaModel_value: MediaCatalogModel? = nil
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    public init() {
        
    }
    /**
     * setMediaId is required to log the mediaId for the media element the log is used for.
     * It needs to be the same that is used inside the app and should be matched with
     * the catalog traits.
     */
    @discardableResult
    public func setMediaId(media_id: String)-> CfLogMediaEventBuilder{
        self.media_id = media_id
        return self
    }
    
    
    /**
     * setMediaType is required to define the type of media being interacted with.
     * It is required to define if the media interacted with is an audio, is a video or an
     * image. SDK provides enums to use for media types.
     * You can also use the string format but usage of enums is appreciated. Below is the
     * method to provide the usage of enum to log the media type.
     */
    @discardableResult
    public func setMediaType(media_type: MediaType) -> CfLogMediaEventBuilder {
        self.media_type = media_type.rawValue
        return self
    }
    
    /**
     * setMediaType is required to define the type of media being interacted with.
     * It is required to define if the media interacted with is an audio, is a video or an
     * image. SDK provides enums to use for media types.
     * You can also use the string format but usage of enums is appreciated. Below is the
     * method to provide the usage of string to log the media type. Remember to use the same
     * strings as provided in the enums or else the event will be discarded.
     */
    @discardableResult
    public func setMediaType(media_type: String) -> CfLogMediaEventBuilder {
        if (MediaType.allCases.filter({$0.rawValue == media_type }).first != nil) {
            self.media_type = media_type
        }else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.media.rawValue, className: String(describing: CfLogMediaEvent.self))
        }
        return self
    }
    
    /**
     * setMediaAction is required to log the interaction action with the media. SDK provides
     * enums to support mediaActions and are defined in 4 different actions.
     * play: to log the start of the media like video or audio or even opening the image.
     * pause: to log the pause event for the audio and video media types.
     * seek: to log the seek event when the user interacts with the seek bar of the video.
     * finish: to log the finish event of the media.
     * Below is the function for providing media action based on enum MediaAction but you
     * can also use string as well.
     */
    @discardableResult
    public  func setMediaAction(media_action: MediaAction) -> CfLogMediaEventBuilder {
        self.media_action = media_action.rawValue
        return self
    }
    
    
    /**
     * setMediaAction is required to log the interaction action with the media. SDK provides
     * enums to support mediaActions and are defined in 4 different actions.
     * play: to log the start of the media like video or audio or even opening the image.
     * pause: to log the pause event for the audio and video media types.
     * seek: to log the seek event when the user interacts with the seek bar of the video.
     * finish: to log the finish event of the media.
     * Below is the function for providing media action based on string but you can also use
     * enum MediaAction as well. Remember to to provide the same string as given in enum or
     * the event will be discarded.
     */
    @discardableResult
    public func setMediaAction(media_action: String)  -> CfLogMediaEventBuilder  {
        if (MediaAction.allCases.filter({$0.rawValue == media_action }).first != nil) {
            self.media_action = media_action
        }else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.media.rawValue, className: String(describing: CfLogMediaEvent.self))
        }
        return self
        
    }
    
    
    /**
     * setCurrentDuration is required to log the current timeframe of the media being interacted with
     * when the action is being performed. It is the timeframe in milliseconds for the
     * audio or when it is played or paused or the final timeframe when it is seek.
     */
    @discardableResult
    public func setCurrentDuration(duration: Float) -> CfLogMediaEventBuilder{
        self.duration_value = Int(duration)
        return self
    }
    
    public func setCurrentDuration(duration: Int?) -> CfLogMediaEventBuilder {
        self.duration_value = duration
        return self
        
    }
    
    @discardableResult
    public func setCurrentDuration(duration: Double) -> CfLogMediaEventBuilder{
        self.duration_value = Int(duration)
        return self
    }
    
    /**
     * setContentBlock is used to specify the type of module the media is in.
     * media can be in any multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlock to log the module, you can also use string function as
     * well in order to log the content block. Below is the function for the usage of enum type
     * function.
     */
    @discardableResult
    public func setContentBlock(content_block: ContentBlock) -> CfLogMediaEventBuilder{
        self.content_block = content_block.rawValue
        return self
    }
    
    /**
     * setContentBlock is used to specify the type of module the media is in.
     * media can be in any multiple modules i.e. core, e-commerce, e-learning, ...
     * SDK provides enum ContentBlock to log the module, you can also use string function as
     * well in order to log the content block. Below is the function for the usage of string type
     * function. Remember to note that you need to use the same enum types as provided by the
     * enums or else the events will be discarded.
     */
    @discardableResult
    public func setContentBlock(content_block: String) -> CfLogMediaEventBuilder {
        if (ContentBlock.allCases.filter({$0.rawValue == content_block}).first != nil) {
            self.content_block = content_block
        } else {
            ExceptionManager.throwEnumException(
                eventType: CoreEventType.media.rawValue,
                className: String(String(describing: CfLogMediaEvent.self))
            )
        }
        return self
    }
    
    @discardableResult
    public func setMediaModel(mediaModelValue: MediaCatalogModel) -> CfLogMediaEventBuilder {
        self.mediaModel_value = mediaModelValue
        return self
    }
    
    @discardableResult
    public func setMediaModel(mediaModelValue: String?) -> CfLogMediaEventBuilder {
        if (mediaModelValue != nil) {
            if let jsonData = mediaModelValue!.data(using: .utf8) {
                // Decode the JSON data into a MediaCatalogModel instance
                do {
                    let mediaModel = try JSONDecoder().decode(MediaCatalogModel.self, from: jsonData)
                    // Use the mediaModel instance as needed
                    print("Decoded mediaModel: \(mediaModel)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        return self
    }
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any?)  -> CfLogMediaEventBuilder  {
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
    public func updateImmediately(update_immediately: Bool) -> CfLogMediaEventBuilder {
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
         * Will throw and exception if the mediaId provided is null or no value is
         * provided at all.
         */
        if  self.media_id!.isNilOREmpty() {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.media.rawValue, elementName: "media_id")
        }
        /**
         * Will throw and exception if the appUserId provided is null or no value is
         * provided at all.
         */
        else if self.mediaModel_value == nil  {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.media.rawValue, elementName: "mediaModel_value")
            
        }
        /**
         * Will throw and exception if the mediaType provided is null or no type is
         * provided at all.
         */
        
        
        else if self.media_type?.isNilOREmpty() == true {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.media.rawValue, elementName: "media_type")
            
            
            if self.media_type != MediaType.image.rawValue {
                if ((self.media_action?.isNilOREmpty()) == true) {
                    ExceptionManager.throwIsRequiredException(eventType: CoreEventType.media.rawValue, elementName: "media_type")
                }
                
                /**
                 * Will throw and exception if the time provided is null or no value is
                 * provided at all in case of type is audio or video.
                 */
                
                if self.duration_value == nil {
                    ExceptionManager.throwIsRequiredException(eventType: CoreEventType.media.rawValue, elementName: "Current Seek Time")
                }
            }else {
                /**
                 * Will override the values for time to current time and mediaAction to
                 * play in case of type is an image.
                 */
                self.media_action = MediaAction.play.rawValue
                self.duration_value = 0
            }
        }else {
            
            
            let mediaObject = MediaObject(id: self.media_id!,type:media_type, action: self.media_action,time:"\(duration_value ?? 0)")
            
            if self.mediaModel_value != nil {
                self.callCatalogAPI()
            }
            CFSetup().track(contentBlockName: self.content_block, eventType:CoreEventType.media.rawValue, logObject: mediaObject, updateImmediately: self.update_immediately)
            
        }
    }
    
    private func callCatalogAPI() {
        guard let mediaModelValue = self.mediaModel_value else {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.media.rawValue, elementName: "media_total_duration")
            return
        }
        
        if let language = mediaModelValue.language, !language.isEmpty {
            
            if !CoreConstants.shared.enumContains(LanguageCode.self, name: language) {
                ExceptionManager.throwEnumException(eventType: CoreEventType.media.rawValue, className:String(describing:LanguageCode))
                return
            }
            self.mediaModel_value?.language = LanguageCode(rawValue: language)?.languageISO2Code
        }
        
        let internalMediaModel = InternalMediaModel(media_id: self.media_id,
                                                    media_name: self.mediaModel_value?.name,
                                                    media_description: self.mediaModel_value?.description,
                                                    type: self.media_type,
                                                    length: self.mediaModel_value?.length,
                                                    resolution: self.mediaModel_value?.resolution,
                                                    language:self.mediaModel_value?.language)
        CFSetup().updateCatalogItem(subject: .media, catalogObject: internalMediaModel)
    }
    
}



