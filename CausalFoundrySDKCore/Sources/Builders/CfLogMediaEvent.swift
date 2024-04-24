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
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately

    init(media_id: String? = nil, media_type: String? = nil, media_action: String? = nil, duration_value: Int? = nil, content_block: String, meta: Any? = nil, update_immediately: Bool) {
        self.media_id = media_id
        self.media_type = media_type
        self.media_action = media_action
        self.duration_value = duration_value
        self.content_block = content_block
        self.meta = meta
        self.update_immediately = update_immediately
    }
}

public class CfLogMediaEventBuilder {
    var media_id: String?
    var media_type: String?
    var media_action: String?
    var duration_value: Int?
    var content_block: String = CoreConstants.shared.contentBlockName
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setMediaId is required to log the mediaId for the media element the log is used for.
     * It needs to be the same that is used inside the app and should be matched with
     * the catalog traits.
     */
    @discardableResult
    public func setMediaId(media_id: String) -> CfLogMediaEventBuilder {
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
        if MediaType.allCases.filter({ $0.rawValue == media_type }).first != nil {
            self.media_type = media_type
        } else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.Media.rawValue, className: String(describing: CfLogMediaEvent.self))
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
    public func setMediaAction(media_action: MediaAction) -> CfLogMediaEventBuilder {
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
    public func setMediaAction(media_action: String) -> CfLogMediaEventBuilder {
        if MediaAction.allCases.filter({ $0.rawValue == media_action }).first != nil {
            self.media_action = media_action
        } else {
            ExceptionManager.throwEnumException(eventType: CoreEventType.Media.rawValue, className: String(describing: CfLogMediaEvent.self))
        }
        return self
    }

    /**
     * setCurrentDuration is required to log the current timeframe of the media being interacted with
     * when the action is being performed. It is the timeframe in milliseconds for the
     * audio or when it is played or paused or the final timeframe when it is seek.
     */
    @discardableResult
    public func setCurrentDuration(duration: Float) -> CfLogMediaEventBuilder {
        duration_value = Int(duration)
        return self
    }

    public func setCurrentDuration(duration: Int?) -> CfLogMediaEventBuilder {
        duration_value = duration
        return self
    }

    @discardableResult
    public func setCurrentDuration(duration: Double) -> CfLogMediaEventBuilder {
        duration_value = Int(duration)
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
    public func setContentBlock(content_block: ContentBlock) -> CfLogMediaEventBuilder {
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
        if ContentBlock.allCases.filter({ $0.rawValue == content_block }).first != nil {
            self.content_block = content_block
        } else {
            ExceptionManager.throwEnumException(
                eventType: CoreEventType.Media.rawValue,
                className: String(String(describing: CfLogMediaEvent.self))
            )
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogMediaEventBuilder {
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
        if media_id?.isNilOREmpty() == true {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Media.rawValue, elementName: "media_id")
            return
        }else if media_type?.isNilOREmpty() == true {
            ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Media.rawValue, elementName: "media_type")
            return
        }else if media_type != MediaType.image.rawValue {
                if (media_action?.isNilOREmpty()) == true {
                    ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Media.rawValue, elementName: "media_type")
                    return
                }
                else if duration_value == nil {
                    ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Media.rawValue, elementName: "Current Seek Time")
                    return
                }
            } else {
                media_action = MediaAction.play.rawValue
                duration_value = 0
            }
    
        let mediaObject = MediaObject(id: media_id!, type: media_type!, action: media_action!, time: duration_value!, meta: meta as? Encodable)
        CFSetup().track(contentBlockName: content_block, eventType: CoreEventType.Media.rawValue, logObject: mediaObject, updateImmediately: update_immediately)
    
    }

}
